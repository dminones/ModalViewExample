//
//  UIViewController+DismissOnTapOutside.h
//  Telly
//
//  Created by Mazyad Alabduljaleel on 5/8/14.
//  Copyright (c) 2014 Telly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DismissOnTapOutside)

- (void)registerForDismissOnTapOutside; // Call in viewDidAppear
- (void)unregisterForDismissOnTapOutside; // Call in viewWillDisappear

@end