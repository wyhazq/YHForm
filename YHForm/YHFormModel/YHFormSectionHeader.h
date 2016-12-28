//
//  YHFormSectionHeader.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHFormSectionHeader : NSObject

@property (nonatomic, copy, nullable) NSString *sectionHeaderType;

@property (nonatomic, assign) CGFloat height;
    
@property (nonatomic, copy, nullable) NSString *text;

@property (nonatomic, copy, nullable) NSString *detailText;

@end
