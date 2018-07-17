/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ReactNativeHaptic.h"
#import <UIKit/UIKit.h>

@implementation ReactNativeHaptic

{
  UIImpactFeedbackGenerator *_impactFeedback;
  UINotificationFeedbackGenerator *_notificationFeedback;
  UISelectionFeedbackGenerator *_selectionFeedback;
  UIImpactFeedbackGenerator *_impactFeedbackHeavy;
  UIImpactFeedbackGenerator *_impactFeedbackMedium;
  UIImpactFeedbackGenerator *_impactFeedbackLight;
}
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (void)setBridge:(RCTBridge *)bridge
{
  _bridge = bridge;
  if ([UIFeedbackGenerator class]) {
    _impactFeedbackHeavy = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    _impactFeedbackMedium = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    _impactFeedbackLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    _impactFeedback = [UIImpactFeedbackGenerator new];
    _notificationFeedback = [UINotificationFeedbackGenerator new];
    _selectionFeedback = [UISelectionFeedbackGenerator new];
  }
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(generate:(NSString *)type)
{
    if ([type isEqual:@"selection"]) {
        [_selectionFeedback selectionChanged];

    } else if ([type isEqual:@"impactLight"]) {
        [_impactFeedbackLight impactOccurred];

    } else if ([type isEqual:@"impactMedium"]) {
        [_impactFeedbackMedium impactOccurred];

    } else if ([type isEqual:@"impactHeavy"]) {
        [_impactFeedbackHeavy impactOccurred];

    } else if ([type isEqual:@"notificationSuccess"]) {
        [_notificationFeedback notificationOccurred:UINotificationFeedbackTypeSuccess];

    } else if ([type isEqual:@"notificationWarning"]) {
        [_notificationFeedback notificationOccurred:UINotificationFeedbackTypeWarning];

    } else if ([type isEqual:@"notificationError"]) {
        [_notificationFeedback notificationOccurred:UINotificationFeedbackTypeError];
    }
}

RCT_EXPORT_METHOD(prepare)
{
  // Only calling prepare on one generator, it's sole purpose is to awake the taptic engine
  [_impactFeedback prepare];
}

@end
