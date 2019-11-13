//
//  UIViewController+HyExtension.m
//  HyCategories
//  https://github.com/hydreamit/HyCategories
//
//  Created by Hy on 2017/9/11.
//  Copyright © 2017 Hy. All rights reserved.
//

#import "UIViewController+HyExtension.h"
#import "UINavigationController+HyExtension.h"
#import "HyRunTimeMethods.h"

@interface HyTopViewControllerManager : NSObject
@property (nonatomic, weak) UIViewController *hy_topViewController;
@end

@implementation HyTopViewControllerManager
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
@end


@implementation UIViewController (HyExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewDidLoad), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self){
                
                HyVoidImpFuctoin(_self, sel);

                [_self hy_viewDidLoad];
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewWillAppear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
                
                if (_self.hy_popGestureState == HyPopGestureState_No) {
                    [_self hy_viewWillAppear:animated];
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewDidAppear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);

                if (_self.hy_popGestureState == HyPopGestureState_No) {
                    [_self hy_viewDidAppear:animated];
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewWillLayoutSubviews), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self){
                
                HyVoidImpFuctoin(_self, sel);
                
                if (_self.hy_popGestureState == HyPopGestureState_No) {
                    [_self hy_viewWillLayoutSubviews];
                }
            };
        });
       
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewDidLayoutSubviews), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self){
                
                HyVoidImpFuctoin(_self, sel);
                
                if (_self.hy_popGestureState == HyPopGestureState_No) {
                    [_self hy_viewDidLayoutSubviews];
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewWillDisappear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
                
                if (_self.hy_popGestureState == HyPopGestureState_No) {
                    [_self hy_viewWillDisappear:animated];
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(viewDidDisappear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
                
                if (_self.hy_popGestureState == HyPopGestureState_No) {
                    [_self hy_viewDidDisappear:animated];
                }
            };
        });
        
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewDidLoad), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self){
                
                HyVoidImpFuctoin(_self, sel);
                
                if (_self.hy_viewDidLoadBlock && !_self.hy_viewDidLoadBlock(_self)) {
                    _self.hy_viewDidLoadBlock = nil;
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewWillAppear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
                
                [HyTopViewControllerManager sharedManager].hy_topViewController = _self;
                if (_self.hy_viewWillAppearBlock && !_self.hy_viewWillAppearBlock(_self, animated)) {
                    _self.hy_viewWillAppearBlock = nil;
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewWillLayoutSubviews), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self){
                
                HyVoidImpFuctoin(_self, sel);
                
                if (_self.hy_viewWillLayoutSubviewsBlock && !_self.hy_viewWillLayoutSubviewsBlock(_self)) {
                    _self.hy_viewWillLayoutSubviewsBlock = nil;
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewDidLayoutSubviews), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self){
                
                HyVoidImpFuctoin(_self, sel);
                
                if (_self.hy_viewDidLayoutSubviewsBlock && !_self.hy_viewDidLayoutSubviewsBlock(_self)) {
                    _self.hy_viewDidLayoutSubviewsBlock = nil;
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewDidAppear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
             
                if (_self.hy_viewDidAppearBlock && !_self.hy_viewDidAppearBlock(_self, animated)) {
                    _self.hy_viewDidAppearBlock = nil;
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewWillDisappear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
                
                if (_self.hy_viewWillDisappearBlock && !_self.hy_viewWillDisappearBlock(_self, animated)) {
                    _self.hy_viewWillDisappearBlock = nil;
                }
            };
        });
        
        hy_swizzleInstanceMethodToBlock([self class], @selector(hy_viewDidDisappear:), ^id(SEL sel, IMP (^impBlock)(void)) {
            
            return ^(UIViewController *_self, BOOL animated){
                
                HyVoidImpFuctoin(_self, sel, animated);
                
                if (_self.hy_viewDidDisappearBlock && !_self.hy_viewDidDisappearBlock(_self, animated)) {
                    _self.hy_viewDidDisappearBlock = nil;
                }
            };
        });
    });
}

+ (UIViewController *)hy_topViewController {
    return [HyTopViewControllerManager sharedManager].hy_topViewController;
}

- (nullable UIViewController *)hy_childViewControllerWithName:(NSString *)name {
    __block UIViewController *vc;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:name]) {
            vc = obj;
            *stop = YES;
        }
    }];
    return vc;
}

- (BOOL)hy_isPresented {
    
    UIViewController *viewController = self;
    if (self.navigationController) {
        if (self.navigationController.hy_rootViewController != self) {
            return NO;
        }
        viewController = self.navigationController;
    }
    return viewController.presentingViewController.presentedViewController == viewController;;
}

- (void)hy_viewDidLoad {}
- (void)hy_viewWillAppear:(BOOL)animated {}
- (void)hy_viewWillLayoutSubviews {}
- (void)hy_viewDidLayoutSubviews {}
- (void)hy_viewDidAppear:(BOOL)animated {}
- (void)hy_viewWillDisappear:(BOOL)animated {}
- (void)hy_viewDidDisappear:(BOOL)animated {}

- (void)setHy_popGestureState:(HyPopGestureState)hy_popGestureState {
    objc_setAssociatedObject(self,
                             @selector(hy_popGestureState),
                             @(hy_popGestureState),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HyPopGestureState)hy_popGestureState {
    NSNumber *state = objc_getAssociatedObject(self, _cmd) ?: @(HyPopGestureState_No);
    return [state integerValue];
}

- (void)setHy_viewDidLoadBlock:(BOOL (^)(UIViewController *))hy_viewDidLoadBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewDidLoadBlock),
                             hy_viewDidLoadBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *))hy_viewDidLoadBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_viewWillAppearBlock:(BOOL (^)(UIViewController *, BOOL))hy_viewWillAppearBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewWillAppearBlock),
                             hy_viewWillAppearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *, BOOL))hy_viewWillAppearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_viewWillLayoutSubviewsBlock:(BOOL (^)(UIViewController *))hy_viewWillLayoutSubviewsBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewWillLayoutSubviewsBlock),
                             hy_viewWillLayoutSubviewsBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *))hy_viewWillLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_viewDidLayoutSubviewsBlock:(BOOL (^)(UIViewController *))hy_viewDidLayoutSubviewsBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewDidLayoutSubviewsBlock),
                             hy_viewDidLayoutSubviewsBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *))hy_viewDidLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_viewDidAppearBlock:(BOOL (^)(UIViewController *, BOOL))hy_viewDidAppearBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewDidAppearBlock),
                             hy_viewDidAppearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *, BOOL))hy_viewDidAppearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_viewWillDisappearBlock:(BOOL (^)(UIViewController *, BOOL))hy_viewWillDisappearBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewWillDisappearBlock),
                             hy_viewWillDisappearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *, BOOL))hy_viewWillDisappearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_viewDidDisappearBlock:(BOOL (^)(UIViewController *, BOOL))hy_viewDidDisappearBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_viewDidDisappearBlock),
                             hy_viewDidDisappearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)(UIViewController *, BOOL))hy_viewDidDisappearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_reloadControllerBlock:(void (^)(id _Nonnull))hy_reloadControllerBlock {
    objc_setAssociatedObject(self,
                             @selector(hy_reloadControllerBlock),
                             hy_reloadControllerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id _Nonnull))hy_reloadControllerBlock {
   return objc_getAssociatedObject(self, _cmd);
}

@end
