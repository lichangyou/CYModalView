//
//  ViewController.m
//  CYModalView
//
//  Created by 李长友 on 2017/2/25.
//  Copyright © 2017年 李长友. All rights reserved.
//

#import "ViewController.h"
#import "CYModalView.h"

@interface ViewController ()

@property (strong, nonatomic) CYModalView *modalView;

@end


@implementation ViewController

- (IBAction)modalViewAction {
    
    [self.modalView present];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalView = [[CYModalView alloc] initWithHeight:300 andViewController:self];
    self.modalView.contentView.backgroundColor = [UIColor blueColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 100, 44);
    button.center = CGPointMake(self.modalView.contentView.frame.size.width / 2, self.modalView.contentView.frame.size.height / 2);
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.modalView.contentView addSubview:button];
}

- (void)push {
    
    [self.modalView dismissWithCompletion:^{
        
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

@end
