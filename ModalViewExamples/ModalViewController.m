//
//  ModalViewController.m
//  ModalViewExamples
//
//  Created by Dario on 12/4/14.
//  Copyright (c) 2014 Cactus. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController (){
    NSInteger _controllerNumber;
}

@property IBOutlet UILabel*label;
-(IBAction)pushController:(id)sender;
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self controllerNumber:_controllerNumber];
    // Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) controllerNumber:(NSInteger)number
{
    _controllerNumber = number;
    self.label.text = [NSString stringWithFormat:@"%d",_controllerNumber];
}

-(IBAction)pushController:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ModalViewController *controller = (ModalViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ModalViewController"];
    
    [controller controllerNumber:_controllerNumber+1];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
