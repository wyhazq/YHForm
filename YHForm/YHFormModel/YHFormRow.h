//
//  YHFormRow.h
//  YHFormExample
//
//  Created by wyh on 2016/11/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHFormSelector.h"
#import "YHFormFormat.h"

@class YHFormSection;

typedef NS_ENUM(NSInteger, YHKeyboardType) {
    YHKeyboardTypeHomePhone = -3,                                               //-3座机
    YHKeyboardTypeIDCard,                                                       //-2身份证
    YHKeyboardTypePassWord,                                                     //-1密码
    YHKeyboardTypeDefault = UIKeyboardTypeDefault,                              //0默认
    YHKeyboardTypeASCIICapable = UIKeyboardTypeASCIICapable,                    //1英文
    YHKeyboardTypeNumbersAndPunctuation = UIKeyboardTypeNumbersAndPunctuation,  //2数字标点
    YHKeyboardTypeURL = UIKeyboardTypeURL,                                      //3URL
    YHKeyboardTypeNumberPad = UIKeyboardTypeNumberPad,                          //4数字
    YHKeyboardTypePhonePad = UIKeyboardTypePhonePad,                            //5电话有*#
    YHKeyboardTypeNamePhonePad = UIKeyboardTypeNamePhonePad,                    //6带九宫格数字的全键盘
    YHKeyboardTypeEmailAddress = UIKeyboardTypeEmailAddress,                    //7邮箱
    YHKeyboardTypeDecimalPad = UIKeyboardTypeDecimalPad,                        //8小数
    YHKeyboardTypeTwitter = UIKeyboardTypeTwitter,                              //9Twitter
    YHKeyboardTypeWebSearch = UIKeyboardTypeWebSearch,                          //10网页
    YHKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable,                        //11英文
};

@interface YHFormRow : NSObject

//Init
+(nonnull instancetype)formRowWithRowType:(nonnull NSString *)rowType key:(nullable id)key;

+(nonnull instancetype)formRowWithRowType:(nonnull NSString *)rowType key:(nullable id)key value:(nullable id)value;

//UI

@property (nonatomic, assign) CGFloat height; //default 55.f

@property (nonatomic, copy, nullable) NSString * title;

@property (nonatomic, copy, nullable) NSString * placeholder;

@property (nonatomic, assign) YHKeyboardType keyboardType;

@property (nonatomic, copy, nullable) NSString *buttonTitle;

@property (nonatomic, copy, nullable) NSString *suffixText;

@property (nonatomic, readonly, nullable) NSString *selectorDisplayText;

@property (nonatomic, readonly, nullable) NSString *customKeyboardKeyString;

@property (nonatomic, readonly, nullable) NSString *textDisplayString;

//本来打算textField加个'-'分割开区号号码分机号传给后台分割，后台不愿意，自己填坑咯......遇到这种后台，可以直接投诉，真的，不用犹豫
//2016-12-14:我感觉这东西就是自己搬石头砸自己的脚
@property (nonatomic, copy, nullable) NSString *separatedString;

//选择器是否能选择
@property (nonatomic, assign, getter=isCanSelecte) BOOL canSelecte;
//不能选择时的提示
@property (nonatomic, copy, nullable) NSString *cannotSelecteTips;

//改变value时的提示
@property (nonatomic, copy, nullable) NSString *changeValueTips;

//获取焦点时清空Value
@property (nonatomic, assign) BOOL clearValueWhenBecomeFirstResponder;

//Data
@property (nonatomic, copy, nonnull) NSString *rowType;

@property (nonatomic, copy, nullable) id key;

@property (nonatomic, strong, nullable) id value;

- (void)setValueFromResponse:(nullable id)response;

@property (nonatomic, copy, nullable) NSArray<YHFormSelector *> *formSelectors;

- (void)configFormSelectors:(nullable NSArray<NSDictionary *> *)selectors;

//为坑爹后台做准备，比如switchControl的on要传0给服务器那种
@property (nonatomic, assign, getter=isSwitchReverse) BOOL switchReverse;

//Format

//用户输入文字格式化
@property (nonatomic, assign) YHFormValueFormatType valueFormatType;

@property (nonatomic, assign) NSUInteger maxTextLength;

//最低数值
@property (nonatomic, assign) CGFloat minNum;

//最高数值
@property (nonatomic, assign) CGFloat maxNum;

//最大日期:@"now"为今天
@property (nonatomic, copy, nullable) NSString *maxDateString;

//Required || Optional
@property (nonatomic, assign, getter=isRequired) BOOL required;

//Check Valid
@property (nonatomic, readonly, getter=isValid) BOOL valid;

@property (nonatomic, assign) YHFormCheckValidType checkValidType;

@property (nonatomic, weak, null_unspecified) YHFormSection * formSection;

@property (nonatomic, readonly, nullable) NSDictionary *rowParameters;

//Get
- (BOOL)isEqualToFormKey:(nullable NSString *)key;

- (BOOL)isEqualToSelector:(nullable YHFormSelector *)formSelector;

/**
 *  don't use this to init
 */
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
- (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
