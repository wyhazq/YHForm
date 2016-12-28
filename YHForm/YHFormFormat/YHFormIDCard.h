//
//  YHFormIDCard.h
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHFormIDCard : NSObject

/**
 *  验证身份证
 *
 *  @param strid 字符串
 *
 *  @return result
 */
+ (BOOL)isIDCard:(NSString*)strid;

//-------- 外部暂时不需要用-------------
+(BOOL)matchesLenght:(NSString*)str;
+(BOOL)matchesNum:(NSString*)str;
+(BOOL)matchesBirth:(NSString*)str;
+(BOOL)matchesAreaCode:(NSString*)str;
+(BOOL)matchesEndNum:(NSString*)str;

@end
