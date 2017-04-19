//
//  OtherViewController.m
//  ACPushOnceDM
//
//  Created by albertchu on 2017/4/19.
//  Copyright © 2017年 albertchu. All rights reserved.
//

#import "OtherViewController.h"

#import "ChatViewController.h"


@interface OtherViewController ()

@end


@implementation OtherViewController

#pragma mark - Action

- (void)pushNext {
    [self.navigationController pushViewController:[[ChatViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Other";
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(pushNext)];
    
}


@end
