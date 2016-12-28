//
//  YHFormVC.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHForm.h"
#import "YYModel.h"

@interface YHFormVC : UIViewController <YHFormDelegate, YHFormTableDelegate>

@property (nonatomic, readonly, nullable) YHFormData *formData;

@end
