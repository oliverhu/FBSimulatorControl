/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <FBSimulatorControl/FBSimulatorInteraction.h>

@protocol FBSimulatorWindowTilingStrategy;

@interface FBSimulatorInteraction (Video)

/**
 Tiles the Simulator according to the 'tilingStrategy'.
 */
- (instancetype)tileSimulator:(id<FBSimulatorWindowTilingStrategy>)tilingStrategy;

/**
 Tiles the Simulator according to the occlusion other Simulators.
 */
- (instancetype)tileSimulator;

/**
 Records Video of the Simulator, until the Session is terminated.
 */
- (instancetype)recordVideo;

@end
