//
//  YHFormTitleView.m
//  YHFormExample
//
//  Created by wyh on 2016/11/19.
//  Copyright © 2016年 . All rights reserved.
//

#import "YHFormTitleView.h"
#import "YHFormConfig.h"
#import "Masonry.h"

@interface YHFormTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *vertLine;

@property (nonatomic, strong) UILabel *requiredLabel;

@property (nonatomic, strong) CAShapeLayer *requiredLayer;

@end

@implementation YHFormTitleView


- (void)setUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.vertLine];
    
    [self.layer addSublayer:self.requiredLayer];
    [self addSubview:self.requiredLabel];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@10);
        make.width.lessThanOrEqualTo(@72);
    }];
    
    [self.vertLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.bottom.equalTo(@-8);
        make.right.equalTo(@0);
        make.width.equalTo(@0.6);
    }];
    
    [self.requiredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@2);
        make.left.equalTo(@2);
        make.width.height.equalTo(@12);
    }];
}

#pragma mark - Set

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

- (void)setIsRequired:(BOOL)isRequired {
    self.requiredLabel.hidden = isRequired;
    self.requiredLayer.hidden = isRequired;
}

#pragma mark - Get

- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont formDefaultFont];
    _titleLabel.textColor = [UIColor formTextColor];
    _titleLabel.numberOfLines = 2;
    return _titleLabel;
}

- (UIView *)vertLine {
    if (_vertLine) return _vertLine;
    
    _vertLine = [[UIView alloc] init];
    _vertLine.backgroundColor = [UIColor lineColor];
    return _vertLine;
}

- (CAShapeLayer *)requiredLayer {
    if (_requiredLayer) return _requiredLayer;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 4)];
    [path addQuadCurveToPoint:CGPointMake(4, 0) controlPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(26, 0)];
    [path addLineToPoint:CGPointMake(0, 26)];
    [path closePath];
    
    _requiredLayer = [CAShapeLayer layer];
    _requiredLayer.path = path.CGPath;
    _requiredLayer.fillColor = [UIColor colorWithWhite:0.78 alpha:0.85].CGColor;
    
    
    return _requiredLayer;
}

- (UILabel *)requiredLabel {
    if (_requiredLabel) return _requiredLabel;
    
    _requiredLabel = [[UILabel alloc] init];
    _requiredLabel.font = [UIFont requireLabelFont];
    _requiredLabel.textColor = [UIColor whiteColor];
    _requiredLabel.textAlignment = NSTextAlignmentCenter;
    _requiredLabel.text = @"选";
    
    return _requiredLabel;
}


@end
