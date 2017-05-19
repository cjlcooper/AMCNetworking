//
//  ViewController.m
//  AMCNetworking
//
//  Created by dynamsoft on 19/05/2017.
//  Copyright © 2017 dynamsoft. All rights reserved.
//

#import "ViewController.h"
#import "AMCNetworkingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AMCNetworkingViewController *amc = [[AMCNetworkingViewController alloc] init];
    [amc networkActionTest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
