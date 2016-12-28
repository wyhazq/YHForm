//
//  YHFormCheckValid.m
//  Neptune
//
//  Created by wyh on 2016/11/24.
//  Copyright © 2016年 NEO Capital. All rights reserved.
//

#import "YHFormCheckValid.h"
#import "SVProgressHUD.h"
#import "YHFormIDCard.h"

@implementation NSString (YHFormCheckValid)

- (BOOL)yh_checkValid:(YHFormCheckValidType)checkValidType {
    
    switch (checkValidType) {
        case YHFormCheckValidTypeDefault: break;
            
        case YHFormCheckValidTypePhone: {
            return [self _yh_isValidPhone];
        } break;
            
        case YHFormCheckValidTypeIDCard: {
            return [self _yh_isValidIDCard];
        } break;
            
        case YHFormCheckValidTypeEmail: {
            return [self _yh_isValidEmail];
        } break;
            
        case YHFormCheckValidTypeCompanyPhone: {
            return [self _yh_isValidCompanyPhone];
        } break;
            
        case YHFormCheckValidTypeHomePhone: {
            return [self _yh_isValidHomePhone];
        } break;
    }
    
    return YES;
}

- (BOOL)_yh_isValidPhone {
    BOOL result = NO;
    if (self.length > 0) {
        NSString * phoneRegex = @"^((13[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        result = [phoneTest evaluateWithObject:self];
        if (!result) {
            [SVProgressHUD showErrorWithStatus:@"手机号码格式错误"];
        }

    }
    return result;
}

- (BOOL)_yh_isValidIDCard {
    BOOL result = NO;
    if (self.length > 0) {
        result = [YHFormIDCard isIDCard:self];
        if(!result){
            [SVProgressHUD showErrorWithStatus:@"身份证号码格式错误"];
        }
    }
    return result;
}

- (BOOL)_yh_isValidEmail {
    BOOL result = NO;
    if (self.length > 0) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
        result = [emailPredicate evaluateWithObject:self];
        if (!result) {
            [SVProgressHUD showErrorWithStatus:@"邮箱格式错误"];
        }
    }
    return result;
}

- (BOOL)_yh_isValidCompanyPhone {
    BOOL result = NO;
    if (self.length > 0) {
        NSString *companyPhoneRegex = @"^\\d+-\\d+(-\\d+)?$";//by 周总
        NSPredicate *companyPhonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", companyPhoneRegex];
        result = [companyPhonePredicate evaluateWithObject:self];
        if (!result) {
            [SVProgressHUD showErrorWithStatus:@"示例:8888-88888888-8888"];
        }
    }
    return result;
}

- (BOOL)_yh_isValidHomePhone {
    BOOL result = NO;
    if (self.length > 0) {
        NSString *homePhoneRegex = @"^\\d+-\\d+?$";//by 周总
        NSPredicate *homePhonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",homePhoneRegex];
        result = [homePhonePredicate evaluateWithObject:self];
        if (!result) {
            [SVProgressHUD showErrorWithStatus:@"示例:8888-88888888"];
        }
    }
    return result;
}


@end
