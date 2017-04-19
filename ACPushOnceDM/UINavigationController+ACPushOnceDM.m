//
//  UINavigationController+ACPushOnceDM.m
//  ACPushOnceDM
//
//  Created by albertchu on 2017/4/19.
//  Copyright © 2017年 albertchu. All rights reserved.
//

#import "UINavigationController+ACPushOnceDM.h"

#import <objc/runtime.h>

#import "ChatViewController.h"


@implementation UINavigationController (ACPushOnceDM)

+ (void)load {
    swizzleMethod([self class], @selector(pushViewController:animated:), @selector(swizzled_pushViewController:animated:));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzled_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[ChatViewController class]]) {
        ChatViewController *viewControllerWillPush = (ChatViewController *)viewController;
        
        UINavigationController *navigationController = self;
        ChatViewController *existingInstance = nil;
        for (UIViewController *vc in navigationController.viewControllers) {
            if ([vc isKindOfClass:[ChatViewController class]]) {
                ChatViewController *existingVC = (ChatViewController *)vc;
                if ([existingVC.catalogID isEqualToString:viewControllerWillPush.catalogID]) {
                    existingInstance = existingVC;
                    break;
                }
            }
        }
        
        if (existingInstance) {
            NSMutableArray *vcs = [[NSMutableArray alloc] initWithArray:navigationController.viewControllers];
            [vcs removeObject:existingInstance];
            [vcs addObject:viewControllerWillPush];
            [navigationController setViewControllers:vcs animated:animated];
        } else {
            // call original implementation
            [self swizzled_pushViewController:viewController animated:animated];
        }
    } else {
        // call original implementation
        [self swizzled_pushViewController:viewController animated:animated];
    }
    
}

@end
