/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "FBSimulatorInteraction+Agents.h"
#import "FBSimulatorInteraction+Private.h"
#import "FBInteraction+Private.h"

#import <CoreSimulator/SimDevice.h>

#import "FBSimulatorApplication.h"
#import "FBProcessQuery.h"
#import "FBProcessLaunchConfiguration+Helpers.h"
#import "FBProcessLaunchConfiguration.h"
#import "FBSimulatorSessionLifecycle.h"
#import "FBSimulator.h"
#import "FBProcessInfo.h"
#import "FBSimulatorError.h"

@implementation FBSimulatorInteraction (Agents)

- (instancetype)launchAgent:(FBAgentLaunchConfiguration *)agentLaunch
{
  NSParameterAssert(agentLaunch);

  FBSimulator *simulator = self.simulator;
  FBSimulatorSessionLifecycle *lifecycle = self.lifecycle;

  return [self interact:^ BOOL (NSError **error, id _) {
    NSError *innerError = nil;
    NSFileHandle *stdOut = nil;
    NSFileHandle *stdErr = nil;
    if (![agentLaunch createFileHandlesWithStdOut:&stdOut stdErr:&stdErr error:&innerError]) {
      return [FBSimulatorError failBoolWithError:innerError errorOut:error];
    }

    NSDictionary *options = [agentLaunch agentLaunchOptionsWithStdOut:stdOut stdErr:stdErr error:error];
    if (!options) {
      return [FBSimulatorError failBoolWithError:innerError errorOut:error];
    }

    pid_t processIdentifier = [simulator.device
      spawnWithPath:agentLaunch.agentBinary.path
      options:options
      terminationHandler:NULL
      error:&innerError];

    if (processIdentifier <= 0) {
      return [[[[FBSimulatorError describeFormat:@"Failed to start Agent %@", agentLaunch] causedBy:innerError] inSimulator:simulator] failBool:error];
    }

    [lifecycle agentDidLaunch:agentLaunch didStartWithProcessIdentifier:processIdentifier stdOut:stdOut stdErr:stdErr];
    return YES;
  }];
}

- (instancetype)killAgent:(FBSimulatorBinary *)agent
{
  NSParameterAssert(agent);

//  FBSimulator *simulator = self.simulator;
//  FBSimulatorSessionLifecycle *lifecycle = self.lifecycle;

  return [self interact:^ BOOL (NSError **error, id _) {

//    id<FBProcessInfo> process = [simulator.processQuery subprocessOf:simulator.launchInfo. withName:<#(NSString *)#>]
//    if (!process) {
//      return [[[FBSimulatorError describeFormat:@"Could not kill agent %@ as it is not running", agent] inSimulator:simulator] failBool:error];
//    }
//
//    [lifecycle agentWillTerminate:agent];
//    if (!kill(state.processIdentifier, SIGKILL)) {
//      return [[[FBSimulatorError describeFormat:@"SIGKILL of Agent %@ of PID %d failed", agent, state.processIdentifier] inSimulator:simulator] failBool:error];
//    }
    return YES;
  }];
}


@end
