//
//  YHFormCell.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFormConfig.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#import "YHFormModel.h"
#import "YHFormTools.h"


@interface YHFormCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, weak) YHFormRow *formRow;

- (void)setUI;

- (void)updateData;

@end
