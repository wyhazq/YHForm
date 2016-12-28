//
//  YHFormRelationshipPicker.h
//  Neptune
//
//  Created by wyh on 2016/12/5.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YHFormRelationshipPickerComplete)(NSArray *relationshipArray);

@interface YHFormRelationshipPicker : UIView

+ (instancetype)pickerWithRelationship:(NSArray<NSDictionary *> *)relationshipArray complete:(YHFormRelationshipPickerComplete)block;

- (void)reset;

@end
