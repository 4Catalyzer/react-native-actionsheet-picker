//
//  CJActionSheetPicker.m
//  CJActionSheetPicker
//
//  Created by Chirag Jain on 5/23/16.
//  Copyright © 2016 Chirag Jain. All rights reserved.
//

#import "CJActionSheetPicker.h"

#import "RCTConvert.h"
#import "RCTLog.h"
#import "RCTUtils.h"

#import "ActionSheetStringPicker.h"

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

@implementation CJActionSheetPicker

RCT_EXPORT_METHOD(showPicker:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    UIViewController *controller = RCTKeyWindow().rootViewController;
    if (controller == nil) {
        RCTLogError(@"Tried to display action sheet but there is no application window. options: %@", options);
        return;
    }
    UIView *sourceView = controller.view;
    
    NSString *title = @"";
    if (options[@"title"]) {
        title = [RCTConvert NSString:options[@"title"]];
    }
    
    NSInteger *selectedIndex = nil;
    if (options[@"selectedIndex"]) {
        selectedIndex = [RCTConvert NSInteger:options[@"selectedIndex"]];
    }
    
    NSArray *rows = [RCTConvert NSArray:options[@"rows"]];
    
    void(^doneBlock)(ActionSheetDatePicker *, id, id) = ^(ActionSheetDatePicker *picker, NSInteger selectedIndex, id selectedValue) {
        resolver(@{
            @"cancelled": @NO,
            @"selectedIndex": @(selectedIndex),
            @"selectedValue": @(selectedValue)
        });
    };
    
    void(^cancelBlock)(ActionSheetDatePicker *) = ^(ActionSheetDatePicker *picker) {
        resolver(@{ @"cancelled": @YES });
    };
    
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:title
                                                                            rows:rows
                                                                initialSelection:selectedIndex
                                                                       doneBlock:doneBlock
                                                                     cancelBlock:cancelBlock
                                                                          origin:sourceView];
    
    
    [picker showActionSheetPicker];
}

@end
