//
//  YHFormIDCard.m
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormIDCard.h"
#import "RegexKitLite.h"

NSString *Ai = nil;

@implementation YHFormIDCard

+ (BOOL)isIDCard:(NSString*)strid{
    Ai = [[NSString alloc]init];
    if([self matchesLenght:strid] && [self matchesNum:strid] && [self matchesBirth:strid] && [self matchesAreaCode:strid] && [self matchesEndNum:strid]){
        return YES;
    }
    return NO;
}
+(BOOL)matchesLenght:(NSString*)str{
    if ( str != nil && (str.length == 15 || str.length == 18)) {
        return YES;
    }
    return NO;
}
+(BOOL)matchesNum:(NSString*)str{
    if (str.length == 18) {
        NSRange range;
        range.location = 0;
        range.length = 17;
        Ai = [str substringWithRange:range];
    } else if (str.length == 15){
        NSRange range1;
        range1.location = 0;
        range1.length = 6;
        NSString* str1 = [str substringWithRange:range1];
        
        NSRange range2;
        range2.location = 7;
        range2.length = 9;
        NSString* str2 = [str substringWithRange:range2];
        Ai = [NSString stringWithFormat:@"%@19%@",str1,str2];
    }
    return [self isNumeric:Ai];
}
+(BOOL)matchesBirth:(NSString*)str{
    BOOL isIdCard = NO;
    NSRange range1;
    range1.location = 6;
    range1.length = 4;
    NSString* strYear = [Ai substringWithRange:range1];// 年份
    
    NSRange range2;
    range2.location = 10;
    range2.length = 2;
    NSString* strMonth = [Ai substringWithRange:range2];// 月份
    
    NSRange range3;
    range3.location = 12;
    range3.length = 2;
    NSString* strDay = [Ai substringWithRange:range3];// 日
    
    if ([self isDate:[NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDay]])
    {
        isIdCard = NO;
    } else {
        isIdCard = YES;
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int inowyear = [[formatter stringFromDate:date] intValue];
    int iyear = [strYear intValue];
    if ((inowyear-iyear) > 150) {
        isIdCard = NO;
    }
    else{
        isIdCard = YES;
    }
    [formatter setDateFormat:@"yyyyMMdd"];
    long long inowtime = [[formatter stringFromDate:date] longLongValue];
    long long itime = [[NSString stringWithFormat:@"%@%@%@",strYear,strMonth,strDay] longLongValue];
    if ((inowtime - itime) < 0) {
        isIdCard = NO;
    }
    else{
        isIdCard = YES;
    }
    
    if ([strMonth intValue] > 12 || [strMonth intValue] == 0) {
        isIdCard = NO;
    } else {
        isIdCard = YES;
    }
    
    if ([strDay intValue] > 31 || [strDay intValue]== 0) {
        isIdCard = NO;
    } else {
        isIdCard = YES;
    }
    return isIdCard;
}

+(BOOL)matchesAreaCode:(NSString*)str{
    BOOL isIdCard = NO;
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
    [mdic setObject:@"北京" forKey:@"11"];
    [mdic setObject:@"天津" forKey:@"12"];
    [mdic setObject:@"河北" forKey:@"13"];
    [mdic setObject:@"山西" forKey:@"14"];
    [mdic setObject:@"内蒙古" forKey:@"15"];
    [mdic setObject:@"辽宁" forKey:@"21"];
    [mdic setObject:@"吉林" forKey:@"22"];
    [mdic setObject:@"黑龙江" forKey:@"23"];
    [mdic setObject:@"上海" forKey:@"31"];
    [mdic setObject:@"江苏" forKey:@"32"];
    [mdic setObject:@"浙江" forKey:@"33"];
    [mdic setObject:@"安徽" forKey:@"34"];
    [mdic setObject:@"福建" forKey:@"35"];
    [mdic setObject:@"江西" forKey:@"36"];
    [mdic setObject:@"山东" forKey:@"37"];
    [mdic setObject:@"河南" forKey:@"41"];
    [mdic setObject:@"湖北" forKey:@"42"];
    [mdic setObject:@"湖南" forKey:@"43"];
    [mdic setObject:@"广东" forKey:@"44"];
    [mdic setObject:@"广西" forKey:@"45"];
    [mdic setObject:@"海南" forKey:@"46"];
    [mdic setObject:@"重庆" forKey:@"50"];
    [mdic setObject:@"四川" forKey:@"51"];
    [mdic setObject:@"贵州" forKey:@"52"];
    [mdic setObject:@"云南" forKey:@"53"];
    [mdic setObject:@"西藏" forKey:@"54"];
    [mdic setObject:@"陕西" forKey:@"61"];
    [mdic setObject:@"甘肃" forKey:@"62"];
    [mdic setObject:@"青海" forKey:@"63"];
    [mdic setObject:@"宁夏" forKey:@"64"];
    [mdic setObject:@"新疆" forKey:@"65"];
    [mdic setObject:@"台湾" forKey:@"71"];
    [mdic setObject:@"香港" forKey:@"81"];
    [mdic setObject:@"澳门" forKey:@"82"];
    [mdic setObject:@"国外" forKey:@"91"];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString* strtemp = [Ai substringWithRange:range];//
    
    if ([mdic objectForKey:strtemp] == nil) {
        isIdCard = NO;
    } else {
        isIdCard = YES;
    }
    return isIdCard;
}
+(BOOL)matchesEndNum:(NSString*)str{
    NSArray* Wi = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6",@"3", @"7",@"9", @"10", @"5", @"8", @"4", @"2", nil ];
    
    NSArray* ValCodeArr = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5",@"4",@"3", @"2", nil];
    
    BOOL isIdCard = NO;
    int TotalmulAiWi = 0;
    for (int i = 0; i < 17; i++) {
        NSRange range;
        range.location = i;
        range.length = 1;
        NSString* strtemp = [Ai substringWithRange:range];//
        TotalmulAiWi = TotalmulAiWi + [strtemp intValue] * [[Wi objectAtIndex:i] intValue];
    }
    int modValue = TotalmulAiWi % 11;
    NSString* strVerifyCode = [ValCodeArr objectAtIndex:modValue];
    Ai = [NSString stringWithFormat:@"%@%@",Ai,strVerifyCode];
    if (str.length == 18) {
        if (![Ai isEqualToString:str]) {
            isIdCard = NO;
        } else {
            isIdCard = YES;
        }
    } else {
        isIdCard = YES;
    }
    return isIdCard;
}

+(BOOL)isNumeric:(NSString*)str{
    if ([str isMatchedByRegex:@"[0-9]*"]) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL)isDate:(NSString*)str{
    BOOL bmach =  [str isMatchedByRegex:@"^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/"
                   @"\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|"
                   @"(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/"
                   @"\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579]"
                   @"[01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|"
                   @"(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))"
                   @"(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$"];
    
    if (bmach) {
        return YES;
    } else {
        return NO;
    }
}

@end
