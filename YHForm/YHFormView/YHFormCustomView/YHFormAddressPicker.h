//
//  YHFormAddressPicker.h
//  YHFormExample
//
//  Created by wyh on 2016/11/21.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

//请按省市区顺序返回...
typedef void(^YHFormAddressPickerComplete)(NSArray *addressArray);

@interface YHFormAddressPicker : UIView

+ (instancetype)addressPickerWithAddress:(NSArray<NSDictionary *> *)address complete:(YHFormAddressPickerComplete)block;


- (void)reset;

@end
