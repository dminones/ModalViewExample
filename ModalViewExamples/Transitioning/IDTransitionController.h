//
//  IDTransitionController.h
//  AnimationExperiments
//
//  Created by Ian Dundas on 24/09/2013.
//  Copyright (c) 2013 Ian Dundas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface IDTransitionController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) bool reverse;
@end
