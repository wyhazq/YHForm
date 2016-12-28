//
//  YHFormDate.m
//  Neptune
//
//  Created by wyh on 2016/12/21.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormDate.h"

@implementation YHFormDate

@end


@implementation NSDate (YHForm)

- (NSString *)yhForm_dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:self];
    return dateString;
}

@end
