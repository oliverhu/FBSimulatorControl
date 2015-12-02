/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>

#import <FBSimulatorControl/FBSimulatorControl.h>

#import "FBSimulatorControlAssertions.h"
#import "FBSimulatorControlFixtures.h"
#import "FBSimulatorControlTestCase.h"
#import "XCTestConfiguration.h"


@interface KIFTestRunner: NSObject

@end

@implementation KIFTestRunner
/**
 Set up XCTestConfigurtionFilePath crap
 2015-11-30 17:31:56.704 xctool[18205:11745952] <XCTestConfiguration: 0x7f9f8dd028e0>
 testBundleURL:file:///Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTests.xctest/
 productModuleName:mntf_ios_sample_appTests
 testsToSkip:
 testsToRun:(null)
 reportResultsToIDE:no
 sessionIdentifier:<__NSConcreteUUID 0x7f9f8dd01870> 56C417B0-EC3F-4AE7-870A-182BD8214042
 pathToXcodeReportingSocket:(null)
 disablePerformanceMetrics:no
	treatMissingBaselinesAsFailures:no
 baselineFileURL:(null)
 targetApplicationPath:(null)
 targetApplicationBundleID:(null)
 reportActivities:no
 */
- (NSDictionary *)testEnvironmentWithSpecifiedTestConfiguration
{
    Class XCTestConfigurationClass = NSClassFromString(@"XCTestConfiguration");
    NSAssert(XCTestConfigurationClass, @"XCTestConfiguration isn't available");

    XCTestConfiguration *configuration = [[XCTestConfigurationClass alloc] init];
    [configuration setProductModuleName:@"mntf_ios_sample_appTests"];
    [configuration setTestBundleURL:[NSURL fileURLWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTests.xctest"]];
    [configuration setReportResultsToIDE:NO];

    NSString *XCTestConfigurationFilename = [NSString stringWithFormat:@"%@-%@", @"mntf_ios_sample_appTests", [configuration.sessionIdentifier UUIDString]];
    NSString *XCTestConfigurationFilePath = [MakeTempFileWithPrefix(XCTestConfigurationFilename) stringByAppendingPathExtension:@"xctestconfiguration"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:XCTestConfigurationFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:XCTestConfigurationFilePath error:nil];
    }
    if (![NSKeyedArchiver archiveRootObject:configuration toFile:XCTestConfigurationFilePath]) {
        NSAssert(NO, @"Couldn't archive XCTestConfiguration to file at path %@", XCTestConfigurationFilePath);
    }

    return @{
             @"XCTestConfigurationFilePath": XCTestConfigurationFilePath,
             };
}

- (NSDictionary *)testEnvironmentWithSpecifiedTestConfiguration2
{
    Class XCTestConfigurationClass = NSClassFromString(@"XCTestConfiguration");
    NSAssert(XCTestConfigurationClass, @"XCTestConfiguration isn't available");

    XCTestConfiguration *configuration = [[XCTestConfigurationClass alloc] init];
    [configuration setProductModuleName:@"mntf_ios_sample_appTests"];
    [configuration setTestBundleURL:[NSURL fileURLWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTestsUI.xctest"]];
    [configuration setReportResultsToIDE:NO];

    NSString *XCTestConfigurationFilename = [NSString stringWithFormat:@"%@-%@", @"mntf_ios_sample_appTestsUI", [configuration.sessionIdentifier UUIDString]];
    NSString *XCTestConfigurationFilePath = [MakeTempFileWithPrefix(XCTestConfigurationFilename) stringByAppendingPathExtension:@"xctestconfiguration"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:XCTestConfigurationFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:XCTestConfigurationFilePath error:nil];
    }
    if (![NSKeyedArchiver archiveRootObject:configuration toFile:XCTestConfigurationFilePath]) {
        NSAssert(NO, @"Couldn't archive XCTestConfiguration to file at path %@", XCTestConfigurationFilePath);
    }

    return @{
             @"XCTestConfigurationFilePath": XCTestConfigurationFilePath,
             };
}

- (NSDictionary *)testEnvironmentWithSpecifiedTestConfigurationVoyager
{
    Class XCTestConfigurationClass = NSClassFromString(@"XCTestConfiguration");
    NSAssert(XCTestConfigurationClass, @"XCTestConfiguration isn't available");

    XCTestConfiguration *configuration = [[XCTestConfigurationClass alloc] init];
    [configuration setProductModuleName:@"mntf_ios_sample_appTests"];
    [configuration setTestBundleURL:[NSURL fileURLWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest"]];
    [configuration setReportResultsToIDE:NO];

    NSString *XCTestConfigurationFilename = [NSString stringWithFormat:@"%@-%@", @"mntf_ios_sample_appTestsUI", [configuration.sessionIdentifier UUIDString]];
    NSString *XCTestConfigurationFilePath = [MakeTempFileWithPrefix(XCTestConfigurationFilename) stringByAppendingPathExtension:@"xctestconfiguration"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:XCTestConfigurationFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:XCTestConfigurationFilePath error:nil];
    }
    if (![NSKeyedArchiver archiveRootObject:configuration toFile:XCTestConfigurationFilePath]) {
        NSAssert(NO, @"Couldn't archive XCTestConfiguration to file at path %@", XCTestConfigurationFilePath);
    }

    return @{
             @"XCTestConfigurationFilePath": XCTestConfigurationFilePath,
             };
}

NSString *MakeTempFileWithPrefix(NSString *prefix)
{
    return MakeTempFileInDirectoryWithPrefix(TemporaryDirectoryForAction(), prefix);
}

NSString *MakeTempFileInDirectoryWithPrefix(NSString *directory, NSString *prefix)
{
    const char *template = [[directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.XXXXXXX", prefix]] UTF8String];

    char tempPath[PATH_MAX] = {0};
    strcpy(tempPath, template);

    int handle = mkstemp(tempPath);
    NSCAssert(handle != -1, @"Failed to make temporary file name for template %s, error: %d", template, handle);
    close(handle);

    return @(tempPath);
}

NSString *TemporaryDirectoryForAction()
{
    if (__tempDirectoryForAction == nil) {
        NSString *nameTemplate = nil;

        // Let our names be consistent while under test - we don't want our tests
        // to have to match against random values.
        if (IsRunningUnderTest()) {
            nameTemplate = [NSString stringWithFormat:@"xctool_temp_UNDERTEST_%d", [[NSProcessInfo processInfo] processIdentifier]];
        } else {
            nameTemplate = @"xctool_temp_XXXXXX";
        }

        __tempDirectoryForAction = MakeTemporaryDirectory(nameTemplate);
    }

    return __tempDirectoryForAction;
}

NSString *MakeTemporaryDirectory(NSString *nameTemplate)
{
    NSMutableData *template = [[[NSTemporaryDirectory() stringByAppendingPathComponent:nameTemplate]
                                dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    [template appendBytes:"\0" length:1];

    if (!mkdtemp(template.mutableBytes) && !IsRunningUnderTest()) {
        NSLog(@"Failed to create temporary directory: %s", strerror(errno));
        abort();
    }

    return [NSString stringWithUTF8String:template.bytes];
}

BOOL IsRunningUnderTest()
{
    NSString *processName = [[NSProcessInfo processInfo] processName];
    return ([processName isEqualToString:@"xctest"] ||
            [processName isEqualToString:@"xctest-x86_64"]);
}

static NSString *__tempDirectoryForAction = nil;
@end

@interface FBSimulatorControlApplicationLaunchTests : FBSimulatorControlTestCase

@end

@implementation FBSimulatorControlApplicationLaunchTests

- (void)testLaunchesSafariApplication
{
  FBSimulatorSession *session = [self createSession];

  FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
    configurationWithApplication:[FBSimulatorApplication systemApplicationNamed:@"MobileSafari"]
    arguments:@[]
    environment:@{}];

  [self.assert interactionSuccessful:[session.interact.bootSimulator launchApplication:appLaunch]];

  [self.assert consumeNotification:FBSimulatorSessionDidStartNotification];
  [self.assert consumeNotification:FBSimulatorSessionSimulatorProcessDidLaunchNotification];
  [self.assert consumeNotification:FBSimulatorSessionApplicationProcessDidLaunchNotification];
  [self.assert noNotificationsToConsume];
}

- (void)testLaunchesSampleApplication
{
  FBSimulatorSession *session = [self createSession];

  FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
    configurationWithApplication:[FBSimulatorControlFixtures tableSearchApplicationWithError:nil]
    arguments:@[]
    environment:@{}];

  [self.assert interactionSuccessful:[[[session.interact
    bootSimulator]
    installApplication:appLaunch.application]
    launchApplication:appLaunch]];

  [self.assert consumeNotification:FBSimulatorSessionDidStartNotification];
  [self.assert consumeNotification:FBSimulatorSessionSimulatorProcessDidLaunchNotification];
  [self.assert consumeNotification:FBSimulatorSessionApplicationProcessDidLaunchNotification];
  [self.assert noNotificationsToConsume];
}

- (void)testMyApp {
    NSError *error = nil;
    FBSimulatorSession *session = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone5 error:&error];
    FBApplicationLaunchConfiguration *appLaunchSafari = [FBApplicationLaunchConfiguration
                                                   configurationWithApplication:[FBSimulatorApplication systemApplicationNamed:@"MobileSafari"]
                                                   arguments:@[]
                                                   environment:@{}];
    BOOL success = [[[session.interact
                      bootSimulator]
                     launchApplication:appLaunchSafari]
                    performInteractionWithError:&error];

    FBSimulatorSession *session2 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
//    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
                                                   configurationWithApplication:myApp
                                                   arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                   environment:@{
                                                                 @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                 @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                 @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                 @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                 @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                 @"NSUnbufferedIO" : @"YES",
                                                                 @"OBJC_DISABLE_GC" : @"YES",
                                                                 @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTests.xctest",
                                                                 @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTests.xctest",
                                                                 @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                 @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfiguration][@"XCTestConfigurationFilePath"]
                                                                 }];
    [[[session2.interact bootSimulator] installApplication:myApp] performInteractionWithError:&error];

//    [[session2.interact bootSimulator] performInteractionWithError:&error];
//    [[session2.interact
//          launchApplication:appLaunch]
//         performInteractionWithError:&error];


    FBSimulatorSession *session3 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
    //    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp2 = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch2 = [FBApplicationLaunchConfiguration
                                                   configurationWithApplication:myApp2
                                                   arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                   environment:@{
                                                                 @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                 @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                 @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                 @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                 @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                 @"NSUnbufferedIO" : @"YES",
                                                                 @"OBJC_DISABLE_GC" : @"YES",
                                                                 @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTests.xctest",
                                                                 @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTests.xctest",
                                                                 @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                 @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfiguration][@"XCTestConfigurationFilePath"]
                                                                 }];
    [[[session3.interact bootSimulator] installApplication:myApp2] performInteractionWithError:&error];

    //    [[session2.interact bootSimulator] performInteractionWithError:&error];
    [[session3.interact
      launchApplication:appLaunch2]
     performInteractionWithError:&error];

    [[session2.interact
      launchApplication:appLaunch]
     performInteractionWithError:&error];

    XCTAssertTrue(success);
    XCTAssertNil(error);

}

- (void)testMyApp2 {
    NSError *error = nil;
    FBSimulatorSession *session = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone5 error:&error];
    FBApplicationLaunchConfiguration *appLaunchSafari = [FBApplicationLaunchConfiguration
                                                         configurationWithApplication:[FBSimulatorApplication systemApplicationNamed:@"MobileSafari"]
                                                         arguments:@[]
                                                         environment:@{}];
    BOOL success = [[[session.interact
                      bootSimulator]
                     launchApplication:appLaunchSafari]
                    performInteractionWithError:&error];

    FBSimulatorSession *session2 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
    //    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
                                                   configurationWithApplication:myApp
                                                   arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                   environment:@{
                                                                 @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                 @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                 @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                 @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                 @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                 @"NSUnbufferedIO" : @"YES",
                                                                 @"OBJC_DISABLE_GC" : @"YES",
                                                                 @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTestsUI.xctest",
                                                                 @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTestsUI.xctest",
                                                                 @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                 @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfiguration2][@"XCTestConfigurationFilePath"]
                                                                 }];
    [[[session2.interact bootSimulator] installApplication:myApp] performInteractionWithError:&error];

    //    [[session2.interact bootSimulator] performInteractionWithError:&error];
    //    [[session2.interact
    //          launchApplication:appLaunch]
    //         performInteractionWithError:&error];


    FBSimulatorSession *session3 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
    //    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp2 = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch2 = [FBApplicationLaunchConfiguration
                                                    configurationWithApplication:myApp2
                                                    arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                    environment:@{
                                                                  @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                  @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                  @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                  @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                  @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator",
                                                                  @"NSUnbufferedIO" : @"YES",
                                                                  @"OBJC_DISABLE_GC" : @"YES",
                                                                  @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTestsUI.xctest",
                                                                  @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-appTestsUI.xctest",
                                                                  @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app/mntf-ios-sample-app",
                                                                  @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfiguration2][@"XCTestConfigurationFilePath"]
                                                                  }];
    [[[session3.interact bootSimulator] installApplication:myApp2] performInteractionWithError:&error];

    //    [[session2.interact bootSimulator] performInteractionWithError:&error];
    [[session3.interact
      launchApplication:appLaunch2]
     performInteractionWithError:&error];

    [[session2.interact
      launchApplication:appLaunch]
     performInteractionWithError:&error];
    
    XCTAssertTrue(success);
    XCTAssertNil(error);
    
}


- (void)testMyAppVoyager {
    NSError *error = nil;
    FBSimulatorSession *session = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone5 error:&error];
    FBApplicationLaunchConfiguration *appLaunchSafari = [FBApplicationLaunchConfiguration
                                                         configurationWithApplication:[FBSimulatorApplication systemApplicationNamed:@"MobileSafari"]
                                                         arguments:@[]
                                                         environment:@{}];
//    BOOL success = [[[session.interact
//                      bootSimulator]
//                     launchApplication:appLaunchSafari]
//                    performInteractionWithError:&error];

    FBSimulatorSession *session2 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
    //    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
                                                   configurationWithApplication:myApp
                                                   arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                   environment:@{
                                                                 @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app/Voyager",
                                                                 @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                 @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator",
                                                                 @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                 @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator",
                                                                 @"NSUnbufferedIO" : @"YES",
                                                                 @"OBJC_DISABLE_GC" : @"YES",
                                                                 @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest",
                                                                 @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest",
                                                                 @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app/Voyager",
                                                                 @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfigurationVoyager][@"XCTestConfigurationFilePath"]
                                                                 }];
    [[[session2.interact bootSimulator] installApplication:myApp] performInteractionWithError:&error];

    //    [[session2.interact bootSimulator] performInteractionWithError:&error];
    //    [[session2.interact
    //          launchApplication:appLaunch]
    //         performInteractionWithError:&error];


    FBSimulatorSession *session3 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
    //    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp2 = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch2 = [FBApplicationLaunchConfiguration
                                                    configurationWithApplication:myApp
                                                    arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                    environment:@{
                                                                  @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app/Voyager",
                                                                  @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                  @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator",
                                                                  @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                  @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator",
                                                                  @"NSUnbufferedIO" : @"YES",
                                                                  @"OBJC_DISABLE_GC" : @"YES",
                                                                  @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest",
                                                                  @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest",
                                                                  @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app/Voyager",
                                                                  @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfigurationVoyager][@"XCTestConfigurationFilePath"]
                                                                  }];
    [[[session3.interact bootSimulator] installApplication:myApp2] performInteractionWithError:&error];


    FBSimulatorSession *session4 = [self.control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone6 error:&error];
    //    FBSimulatorApplication *myApp = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/mntf-ios-sample-app-cixnsqxcijpgqucewcxjaxekeets/Build/Products/Debug-iphonesimulator/mntf-ios-sample-app.app" error:&error];
    FBSimulatorApplication *myApp4 = [FBSimulatorApplication applicationWithPath:@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app" error:&error];
    FBApplicationLaunchConfiguration *appLaunch4 = [FBApplicationLaunchConfiguration
                                                    configurationWithApplication:myApp4
                                                    arguments:@[@"-NSTreatUnknownArgumentsAsOpen", @"NO", @"-ApplePersistenceIgnoreState", @"YES"]
                                                    environment:@{
                                                                  @"AppTargetLocation":@"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app/Voyager",
                                                                  @"DYLD_FALLBACK_FRAMEWORK_PATH": @"/Applications/Xcode 2.app/Contents/Developer/Library/Frameworks:/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks",
                                                                  @"DYLD_FRAMEWORK_PATH" :@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator",
                                                                  @"DYLD_INSERT_LIBRARIES" : @"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
                                                                  @"DYLD_LIBRARY_PATH":@"/Applications/Xcode 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks:/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator",
                                                                  @"NSUnbufferedIO" : @"YES",
                                                                  @"OBJC_DISABLE_GC" : @"YES",
                                                                  @"TestBundleLocation" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest",
                                                                  @"XCInjectBundle" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/VoyagerTests.xctest",
                                                                  @"XCInjectBundleInto" : @"/Users/khu/Library/Developer/Xcode/DerivedData/voyager-aodwsnztqjhrikgifstschfgfhzf/Build/Products/Debug-iphonesimulator/Voyager.app/Voyager",
                                                                  @"XCTestConfigurationFilePath": [[[KIFTestRunner alloc] init] testEnvironmentWithSpecifiedTestConfigurationVoyager][@"XCTestConfigurationFilePath"]
                                                                  }];
    [[[session4.interact bootSimulator] installApplication:myApp4] performInteractionWithError:&error];

    //    [[session2.interact bootSimulator] performInteractionWithError:&error];

    [[session3.interact
      launchApplication:appLaunch2]
     performInteractionWithError:&error];

    [[session4.interact
      launchApplication:appLaunch4]
     performInteractionWithError:&error];

    [[session2.interact
      launchApplication:appLaunch]
     performInteractionWithError:&error];

//    XCTAssertTrue(success);
    XCTAssertNil(error);
    
}

@end


