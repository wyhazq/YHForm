//
//  YHFormScrollView.m
//  NRD
//
//  Created by wyh on 2016/10/14.
//  Copyright © 2016年 深圳市小牛资本管理集团. All rights reserved.
//

#import "YHFormScrollView.h"

@interface YHFormScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat currentOffsetX;

@end

@implementation YHFormScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.directionalLockEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self && ([keyPath isEqualToString:@"contentOffset"])) {
        if (self.isDragging) {
            if (self.contentOffset.x > self.currentOffsetX) {
                self.scrollEnabled = NO;
            }
        }
        if (self.contentOffset.x <= self.currentOffsetX) {
            self.scrollEnabled = YES;
        }
    }
}

- (void)dealloc {
    @try {
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }
    @catch (NSException * __unused exception) {}
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentOffsetX = scrollView.contentOffset.x;
}

#pragma mark - Action

- (void)nextPage {
    _currentOffsetX = self.contentOffset.x + CGRectGetWidth(self.bounds);
    [self scrollRectToVisible:CGRectMake(self.currentOffsetX, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) animated:YES];
}

#pragma mark - Gesture

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Get

- (NSInteger)pageIndex {
    return (long)roundf(self.contentOffset.x / CGRectGetWidth(self.bounds));
}

- (NSInteger)pageCount {
    return self.contentSize.width / CGRectGetWidth(self.bounds);
}

- (BOOL)isLastPage {
    return self.contentOffset.x + CGRectGetWidth(self.bounds) >= self.contentSize.width;
}

@end
