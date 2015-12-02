/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "FBSimulatorInteraction+Diagnostics.h"

#import "FBSimulatorApplication.h"
#import "FBSimulatorError.h"
#import "FBSimulatorSession+Private.h"
#import "FBSimulatorSession.h"
#import "FBSimulatorInteraction+Private.h"
#import "FBSimulatorInteraction+Diagnostics.h"
#import "FBSimulatorSessionLifecycle.h"
#import "FBSimulatorSessionState+Queries.h"
#import "FBTaskExecutor.h"

typedef id<FBTask>(^FBDiagnosticTaskFactory)(FBTaskExecutor *executor, pid_t processIdentifier);

@implementation FBSimulatorInteraction (Diagnostics)

- (instancetype)sampleApplication:(FBSimulatorApplication *)application withDuration:(NSInteger)durationInSeconds frequency:(NSInteger)frequencyInMilliseconds
{
  return [self asyncDiagnosticOnApplication:application name:@"stack_sample" taskFactory:^ id<FBTask> (FBTaskExecutor *executor, pid_t processIdentifier) {
    return [executor
      taskWithLaunchPath:@"/usr/bin/sample"
      arguments:@[@(processIdentifier).stringValue, @(durationInSeconds).stringValue, @(frequencyInMilliseconds).stringValue]];
  }];
}

- (instancetype)onApplication:(FBSimulatorApplication *)application executeLLDBCommand:(NSString *)command
{
  NSParameterAssert(command);

  return [self syncDiagnosticOnApplication:application name:@"lldb_command" taskFactory:^id<FBTask>(FBTaskExecutor *executor, pid_t processIdentifier) {
    return [[[[executor
      withLaunchPath:@"/usr/bin/lldb"]
      withArguments:@[@"-p", @(processIdentifier).stringValue, @"-o", command, @"-o", @"script import os; os._exit(1)"]]
      withAcceptableTerminationStatusCodes:[NSSet setWithArray:@[@0, @1]]]
      build];
  }];
}

#pragma mark Private

- (instancetype)asyncDiagnosticOnApplication:(FBSimulatorApplication *)application name:(NSString *)name taskFactory:(FBDiagnosticTaskFactory)taskFactory
{
  NSParameterAssert(application);
  NSParameterAssert(name);
  FBSimulatorSessionLifecycle *lifecycle = self.lifecycle;

  return [self binary:application.binary interact:^ BOOL (id<FBProcessInfo> process, NSError **error) {
    id<FBTask> task = taskFactory(FBTaskExecutor.sharedInstance, process.processIdentifier);
    NSCAssert(task, @"Task should not be nil");

    [lifecycle associateEndOfSessionCleanup:task];
    [task startAsynchronouslyWithTerminationHandler:^(id<FBTask> innerTask) {
      if (innerTask.error) {
        return;
      }

      [lifecycle application:application didGainDiagnosticInformationWithName:name data:innerTask.stdOut];
    }];

    if (task.error) {
      return [FBSimulatorError failBoolWithError:task.error errorOut:error];
    }
    return YES;
  }];
}

- (instancetype)syncDiagnosticOnApplication:(FBSimulatorApplication *)application name:(NSString *)name taskFactory:(FBDiagnosticTaskFactory)taskFactory
{
  NSParameterAssert(application);
  NSParameterAssert(name);
  FBSimulatorSessionLifecycle *lifecycle = self.lifecycle;

  return [self binary:application.binary interact:^ BOOL (id<FBProcessInfo> process, NSError **error) {
    id<FBTask> task = taskFactory(FBTaskExecutor.sharedInstance, process.processIdentifier);
    NSCAssert(task, @"Task should not be nil");

    [task startSynchronouslyWithTimeout:FBSimulatorDefaultTimeout];
    if (task.error) {
      return [FBSimulatorError failBoolWithError:task.error errorOut:error];
    }
    [lifecycle application:application didGainDiagnosticInformationWithName:name data:task.stdOut];
    return YES;
  }];
}

@end
