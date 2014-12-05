//
//  ViewController.m
//  ModalViewExamples
//
//  Created by Dario on 12/4/14.
//  Copyright (c) 2014 Cactus. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "ModalNavigationController.h"


@interface ViewController ()
-(IBAction)openModal:(id)sender;
@end

@implementation ViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)openModal:(id)sender{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ModalViewController *controller = (ModalViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ModalViewController"];
    ModalNavigationController *nav = [[ModalNavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:nav animated:YES completion:nil];
}

@end
