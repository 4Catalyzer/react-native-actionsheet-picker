#import "CJActionSheetPicker.h"

#import "RCTConvert.h"
#import "RCTLog.h"
#import "RCTUtils.h"

#import "ActionSheetStringPicker.h"
#import "ActionSheetStringMultipleSelectionPicker.h"
#import "ActionSheetDatePicker.h"

@implementation CJActionSheetPicker

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(showStringPicker:(NSDictionary *)options
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

    BOOL multiple = options[@"multiple"] ? YES : NO;

    NSArray *rows = [RCTConvert NSArray:options[@"rows"]];

    void(^cancelBlock)(AbstractActionSheetPicker *) = ^(AbstractActionSheetPicker *picker) {
        resolve(@{ @"cancelled": @YES });
    };

    if (multiple) {
        NSArray<NSNumber *> *selectedIndices = nil;
        if (options[@"selectedIndices"]) {
            selectedIndices = [RCTConvert NSNumberArray:options[@"selectedIndices"]];
        }

        void(^doneBlock)(ActionSheetStringMultipleSelectionPicker *, NSArray*, id) = ^(ActionSheetStringMultipleSelectionPicker *picker, NSArray *selectedIndices, id selectedValues) {
            resolve(@{
                @"cancelled": @NO,
                @"selectedIndices": selectedIndices,
                @"selectedValues": (NSArray *)selectedValues
            });
        };

        [ActionSheetStringMultipleSelectionPicker showPickerWithTitle:title
                                                                 rows:rows
                                                     initialSelection:selectedIndices
                                                            doneBlock:doneBlock
                                                          cancelBlock:cancelBlock
                                                               origin:sourceView];
    } else {

        NSInteger *selectedIndex = nil;
        if (options[@"selectedIndex"]) {
            selectedIndex = [RCTConvert NSInteger:options[@"selectedIndex"]];
        }

        void(^doneBlock)(ActionSheetStringPicker *, NSInteger, id) = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            resolve(@{
                @"cancelled": @NO,
                @"selectedIndex": @(selectedIndex),
                @"selectedValue": (NSString *)selectedValue
            });
        };

        [ActionSheetStringPicker showPickerWithTitle:title
                                                rows:rows
                                    initialSelection:selectedIndex
                                           doneBlock:doneBlock
                                         cancelBlock:cancelBlock
                                              origin:sourceView];
    }
}

RCT_EXPORT_METHOD(showCountDownPicker:(NSDictionary *)options
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

    void(^doneBlock)(ActionSheetDatePicker *, id, id) = ^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        resolve(@{ @"cancelled": @NO, @"countDownDuration": selectedDate });
    };

    void(^cancelBlock)(ActionSheetDatePicker *) = ^(ActionSheetDatePicker *picker) {
        resolve(@{ @"cancelled": @YES });
    };

    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                      datePickerMode:UIDatePickerModeCountDownTimer
                                                                        selectedDate:nil
                                                                           doneBlock:doneBlock
                                                                         cancelBlock:cancelBlock
                                                                              origin:sourceView];

    if (options[@"countDownDuration"]) {
        datePicker.countDownDuration = [RCTConvert double:options[@"countDownDuration"]];
    }
    [datePicker showActionSheetPicker];
}

@end
