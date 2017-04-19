//
//  ChatViewController.m
//  ACPushOnceDM
//
//  Created by albertchu on 2017/4/19.
//  Copyright © 2017年 albertchu. All rights reserved.
//

#import "ChatViewController.h"

#import "OtherViewController.h"


@interface ChatViewController ()

@property (nonatomic, strong, readwrite) NSString *catalogID;

@end


@implementation ChatViewController

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization

        // fake id
        _catalogID = @"42";
    }
    return self;
}


#pragma mark - Action

- (void)pushNext {
    [self.navigationController pushViewController:[[OtherViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Chat";
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(pushNext)];
    
}


@end
