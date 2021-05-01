//
//  UIScrollView+HyExtension.m
//  HyCategories
//  https://github.com/hydreamit/HyCategories
//
//  Created by Hy on 2017/8/29.
//  Copyright © 2017 Hy. All rights reserved.
//

#import "UIScrollView+HyExtension.h"
#import "HyRunTimeMethods.h"


@interface HyScrollViewDelegateConfigure () <UIScrollViewDelegate>
@property (nonatomic,copy) void (^scrollViewDidScroll)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewDidZoom)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewWillBeginDragging)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewWillBeginDecelerating)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewDidEndDecelerating)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewDidEndScrollingAnimation)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewDidScrollToTop)(UIScrollView *scrollView);
@property (nonatomic,copy) BOOL (^scrollViewShouldScrollToTop)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewDidChangeAdjustedContentInset)(UIScrollView *scrollView);
@property (nonatomic,copy) UIView *(^viewForZoomingInScrollView)(UIScrollView *scrollView);
@property (nonatomic,copy) void (^scrollViewWillBeginZooming)(UIScrollView *scrollView, UIView *view);
@property (nonatomic,copy) void (^scrollViewDidEndZooming)(UIScrollView *scrollView, UIView *view, CGFloat scale);
@property (nonatomic,copy) void (^scrollViewWillEndDragging)(UIScrollView *scrollView, CGPoint velocity, CGPoint targetContentOffset);
@property (nonatomic,copy) void (^scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL willDecelerate);
@end


@implementation HyScrollViewDelegateConfigure

- (HyScrollViewDelegateConfigure *(^)(NSString *, id (^)(void)))addDelegateMethod {
    __weak typeof(self) _self = self;
    return ^(NSString *selString, id (^impBlock)(void)) {
        __strong typeof(_self) self = _self;
        SEL sel = sel_registerName(selString.UTF8String);
        Method method = class_getInstanceMethod([self class], sel);
        if (!method) {
            if (impBlock) {
                class_addMethod(self.class, sel, imp_implementationWithBlock(impBlock()), "v@:@");
            }
        }
        return self;
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewDidScroll {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidScroll = [block copy];
        return self.addDelegateMethod(@"scrollViewDidScroll:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewDidScroll ?:_self.scrollViewDidScroll(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewDidZoom {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidZoom = [block copy];
        return self.addDelegateMethod(@"scrollViewDidZoom:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewDidZoom ?:_self.scrollViewDidZoom(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewWillBeginDragging {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewWillBeginDragging = [block copy];
        return self.addDelegateMethod(@"scrollViewWillBeginDragging:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewWillBeginDragging ?:_self.scrollViewWillBeginDragging(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewWillBeginDecelerating {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewWillBeginDecelerating = [block copy];
        return self.addDelegateMethod(@"scrollViewWillBeginDecelerating:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewWillBeginDecelerating ?:_self.scrollViewWillBeginDecelerating(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewDidEndDecelerating {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidEndDecelerating = [block copy];
        return self.addDelegateMethod(@"scrollViewDidEndDecelerating:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewDidEndDecelerating ?:_self.scrollViewDidEndDecelerating(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewDidEndScrollingAnimation {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidEndScrollingAnimation = [block copy];
        return self.addDelegateMethod(@"scrollViewDidEndScrollingAnimation:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewDidEndScrollingAnimation ?:_self.scrollViewDidEndScrollingAnimation(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewDidScrollToTop {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidScrollToTop = [block copy];
        return self.addDelegateMethod(@"scrollViewDidScrollToTop:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewDidScrollToTop ?:_self.scrollViewDidScrollToTop(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *)))configScrollViewDidChangeAdjustedContentInset {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidChangeAdjustedContentInset = [block copy];
        return self.addDelegateMethod(@"scrollViewDidChangeAdjustedContentInset:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                !_self.scrollViewDidChangeAdjustedContentInset ?:_self.scrollViewDidChangeAdjustedContentInset(_scrollview);
            };
        });
    };
}


- (HyScrollViewDelegateConfigure *(^)(BOOL (^)(UIScrollView *)))configScrollViewShouldScrollToTop {
    __weak typeof(self) _self = self;
    return ^(BOOL (^block)(UIScrollView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewShouldScrollToTop = [block copy];
        return self.addDelegateMethod(@"scrollViewShouldScrollToTop:", ^id {
            return ^BOOL(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                return !_self.scrollViewShouldScrollToTop ? YES :_self.scrollViewShouldScrollToTop(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(UIView *(^)(UIScrollView *)))configScrollViewForZoomingInScrollView {
    __weak typeof(self) _self = self;
    return ^(UIView *(^block)(UIScrollView *scrollView)) {
        __strong typeof(_self) self = _self;
        self.viewForZoomingInScrollView = [block copy];
        return self.addDelegateMethod(@"configScrollViewForZoomingInScrollView:", ^id {
            return ^UIView *(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                return !_self.viewForZoomingInScrollView ? nil :_self.viewForZoomingInScrollView(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *, UIView *)))configScrollViewWillBeginZooming {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *, UIView *)) {
        __strong typeof(_self) self = _self;
        self.scrollViewWillBeginZooming = [block copy];
        return self.addDelegateMethod(@"scrollViewShouldScrollToTop:", ^id {
            return ^BOOL(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview) {
                return !_self.scrollViewShouldScrollToTop ? YES :_self.scrollViewShouldScrollToTop(_scrollview);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *, UIView *, CGFloat)))configScrollViewDidEndZooming {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *, UIView *, CGFloat)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidEndZooming = [block copy];
        return self.addDelegateMethod(@"scrollViewDidEndZooming:withView:atScale:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview, UIView *view, CGFloat scale) {
               !_self.scrollViewDidEndZooming ?:_self.scrollViewDidEndZooming(_scrollview, view, scale);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *, CGPoint, CGPoint)))configScrollViewWillEndDragging {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *, CGPoint, CGPoint)) {
        __strong typeof(_self) self = _self;
        self.scrollViewWillEndDragging = [block copy];
        return self.addDelegateMethod(@"scrollViewWillEndDragging:withVelocity:targetContentOffset:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview, CGPoint velocity,  CGPoint * targetContentOffset) {
               !_self.scrollViewWillEndDragging ?:_self.scrollViewWillEndDragging(_scrollview, velocity, *targetContentOffset);
            };
        });
    };
}

- (HyScrollViewDelegateConfigure *(^)(void (^)(UIScrollView *, BOOL)))configScrollViewDidEndDragging {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIScrollView *, BOOL)) {
        __strong typeof(_self) self = _self;
        self.scrollViewDidEndDragging = [block copy];
        return self.addDelegateMethod(@"scrollViewDidEndDragging:willDecelerate:", ^id {
            return ^(HyScrollViewDelegateConfigure *_self, UIScrollView *_scrollview, BOOL decelerate) {
               !_self.scrollViewDidEndDragging ?:_self.scrollViewDidEndDragging(_scrollview, decelerate);
            };
        });
    };
}

- (void)dealloc {
    if (![self isMemberOfClass:HyScrollViewDelegateConfigure.class] &&
        [NSStringFromClass(self.class) hasSuffix:@"HyScrollViewDelegateConfigure_"]) {
        Class cls = self.class;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            objc_disposeClassPair(cls);
        });
    }
}
@end

@interface UIScrollView ()
@property (nonatomic,strong) HyScrollViewDelegateConfigure *hy_delegateConfigure;
@end
@implementation UIScrollView (HyExtension)

+ (instancetype)hy_scrollViewWithFrame:(CGRect)frame
                              delegate:(id<UIScrollViewDelegate>)delegate {
    
    UIScrollView *scrollView = [[self alloc] initWithFrame:frame];
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scrollView.delegate = delegate;
    return scrollView;
}

+ (instancetype)hy_scrollViewWithFrame:(CGRect)frame
                     delegateConfigure:(void(^)(HyScrollViewDelegateConfigure *configure))delegateConfigure {
    
    UIScrollView *scrollView = [[self alloc] initWithFrame:frame];
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scrollView.hy_delegateConfigure = scrollView.delegateInstance;
    !delegateConfigure ?: delegateConfigure(scrollView.hy_delegateConfigure);
    scrollView.delegate = scrollView.hy_delegateConfigure;
    return scrollView;
}

- (HyScrollViewDelegateConfigure *)delegateInstance {
    const char *clasName = [[NSString stringWithFormat:@"HyScrollViewDelegateConfigure_%d_%d", arc4random() % 100, arc4random() % 100] cStringUsingEncoding:NSASCIIStringEncoding];
    if (!objc_getClass(clasName)){
        objc_registerClassPair(objc_allocateClassPair(HyScrollViewDelegateConfigure.class, clasName, 0));
        return [[objc_getClass(clasName) alloc] init];;
    } else {
        return [self delegateInstance];
    }
}

- (void)setHy_delegateConfigure:(HyScrollViewDelegateConfigure *)hy_delegateConfigure {
    
    objc_setAssociatedObject(self,
                             @selector(hy_delegateConfigure),
                             hy_delegateConfigure,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HyScrollViewDelegateConfigure *)hy_delegateConfigure {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)hy_isAtTop {
    if (((NSInteger)self.contentOffset.y) == -((NSInteger)self.hy_contentInset.top)) {
        return YES;
    }
    return NO;
}

- (BOOL)hy_isAtBottom {
    if (!self.hy_canScroll) {
        return YES;
    }
    if (((NSInteger)self.contentOffset.y) == ((NSInteger)self.contentSize.height + self.hy_contentInset.bottom - CGRectGetHeight(self.bounds))) {
        return YES;
    }
    return NO;
}

- (BOOL)hy_isAtLeft {
    if (((NSInteger)self.contentOffset.x) == -((NSInteger)self.hy_contentInset.left)) {
        return YES;
    }
    return NO;
}

- (BOOL)hy_isAtRight {
    if (!self.hy_canScroll) {
        return YES;
    }
    if (((NSInteger)self.contentOffset.x) == ((NSInteger)self.contentSize.width + self.hy_contentInset.left - CGRectGetWidth(self.bounds))) {
        return YES;
    }
    return NO;
}

- (BOOL)hy_canScroll {
    
    if (CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        return NO;
    }
    BOOL canVerticalScroll = self.contentSize.height + self.hy_contentInset.top + self.hy_contentInset.bottom > CGRectGetHeight(self.bounds);
    BOOL canHorizontalScoll = self.contentSize.width + self.hy_contentInset.left + self.hy_contentInset.right > CGRectGetWidth(self.bounds);
    return canVerticalScroll || canHorizontalScoll;
}

- (UIEdgeInsets)hy_contentInset {
    if (@available(iOS 11, *)) {
        return self.adjustedContentInset;
    } else {
        return self.hy_contentInset;
    }
}

- (void)hy_scrollToTopAnimated:(BOOL)animated {
    
    CGPoint off = self.contentOffset;
    off.y = 0 - self.hy_contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)hy_scrollToBottomAnimated:(BOOL)animated {
    
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.hy_contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)hy_scrollToLeftAnimated:(BOOL)animated {
    
    CGPoint off = self.contentOffset;
    off.x = 0 - self.hy_contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)hy_scrollToRightAnimated:(BOOL)animated {
    
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.hy_contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
