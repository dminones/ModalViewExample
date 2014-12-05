//
//  UIViewController+DismissOnTapOutside.m
//  Telly
//
//  Created by Mazyad Alabduljaleel on 5/8/14.
//  Copyright (c) 2014 Telly, Inc. All rights reserved.
//

#import "UIViewController+DismissOnTapOutside.h"
#import <objc/runtime.h>

static char gestureRecognizerKey;
static char gestureRecognizerDelegateKey;

@interface SimpleGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@end

@implementation SimpleGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return ![otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UINavigationBar")];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return ![otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UIDimmingView")];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return [touch.view isKindOfClass:NSClassFromString(@"UIDimmingView")];;
}

@end

@interface UIViewController ()

@property (assign, nonatomic) UIGestureRecognizer *gestureRecognizer;
@property (strong, nonatomic) SimpleGestureRecognizerDelegate *gestureRecognizerDelegate;

@end

@implementation UIViewController (DismissOnTapOutside)

- (void)setGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    objc_setAssociatedObject(self, &gestureRecognizerKey, gestureRecognizer, OBJC_ASSOCIATION_ASSIGN);
}

- (UIGestureRecognizer *)gestureRecognizer
{
    return objc_getAssociatedObject(self, &gestureRecognizerKey);
}

- (void)setGestureRecognizerDelegate:(SimpleGestureRecognizerDelegate *)delegate
{
    objc_setAssociatedObject(self, &gestureRecognizerDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIGestureRecognizer *)gestureRecognizerDelegate
{
    id delegate = objc_getAssociatedObject(self, &gestureRecognizerDelegateKey);
    if (!delegate)
    {
        delegate = [[SimpleGestureRecognizerDelegate alloc] init];
        self.gestureRecognizerDelegate = delegate;
    }
    
    return delegate;
}

- (void)handleDismissTap:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        UIView *view = self.view;
        CGPoint location = [gesture locationInView:view];
        NSLog(@"Frame: %f,%f,%f,%f",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        if (![view pointInside:location withEvent:nil])
        {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)registerForDismissOnTapOutside
{
    // This approach is attributed to Danilo Campos:
    // http://stackoverflow.com/a/6180584/456434
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissTap:)];
    recognizer.delegate = self.gestureRecognizerDelegate;
    recognizer.numberOfTapsRequired = 1;
    recognizer.cancelsTouchesInView = YES;
    
    self.gestureRecognizer = recognizer;
    [self.view.window addGestureRecognizer:recognizer];
}

- (void)unregisterForDismissOnTapOutside
{
    [self.view.window removeGestureRecognizer:self.gestureRecognizer];
    self.gestureRecognizer = nil;
}

@end