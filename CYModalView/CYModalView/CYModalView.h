//
//  CYModalView.h
//  CYModalView
//
//  Created by 李长友 on 2017/2/25.
//  Copyright © 2017年 李长友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYModalView : UIView

@property (strong, nonatomic) UIView *contentView;

- (instancetype)initWithHeight:(CGFloat)height andViewController:(UIViewController *)viewController;
- (void)present;
- (void)dismiss;
- (void)dismissWithCompletion:(void (^)())completion;

@end
