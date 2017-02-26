//
//  CYModalView.m
//  CYModalView
//
//  Created by 李长友 on 2017/2/25.
//  Copyright © 2017年 李长友. All rights reserved.
//

#import "CYModalView.h"
#import <QuartzCore/QuartzCore.h>

@interface CYModalView ()

@property (strong, nonatomic) UIControl *dismissControl;
@property (strong, nonatomic) UIImageView *maskImageView;
@property (strong, nonatomic) UIViewController *viewController;

@end


@implementation CYModalView

- (instancetype)initWithHeight:(CGFloat)height andViewController:(UIViewController *)viewController {
    
    if (self = [super init]) {
        [self setupUI];
        _contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, height);
        self.viewController = viewController;
        if (viewController) {
            [viewController.view insertSubview:self atIndex:0];
            [viewController.view sendSubviewToBack:self];
        }
    }
    return self;
}

- (void)setupUI {
    
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [UIColor blackColor];
    
    _maskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [self addSubview:_maskImageView];
    
    _dismissControl = [[UIControl alloc] initWithFrame:self.bounds];
    _dismissControl.userInteractionEnabled = NO;
    _dismissControl.backgroundColor = [UIColor clearColor];
    [_dismissControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dismissControl];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
}

+ (UIImage *)imageWithWindow {
    
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions([UIApplication sharedApplication].keyWindow.bounds.size, YES, 2);
        [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

- (void)present {
    
    CATransform3D t = CATransform3DIdentity;
    t.m34 = - 1 / 300.0;
    [_maskImageView.layer setTransform:t];
    _maskImageView.layer.zPosition = -10000;
    
    _maskImageView.image = [self.class imageWithWindow];
    if (self.viewController) {
        [self.viewController.view bringSubviewToFront:self];
    }
    _dismissControl.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.5f animations:^{
        _maskImageView.alpha = 0.5;
        _contentView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - _contentView.bounds.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.25f animations:^{
        _maskImageView.layer.transform = CATransform3DRotate(t, 7/90.0 * M_PI_2, 1, 0, 0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            _maskImageView.layer.transform = CATransform3DTranslate(t, 0, -30, -40);
        }];
    }];
}

- (void)dismiss {
    
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(void (^)())completion {
    
    CATransform3D t = CATransform3DIdentity;
    t.m34 = - 1 / 300.0;
    [_maskImageView.layer setTransform:t];
    _dismissControl.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.5f animations:^{
        _maskImageView.alpha = 1;
        _contentView.frame = CGRectMake(0, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    } completion:^(BOOL finished) {
        if (self.viewController) {
            [self.viewController.view sendSubviewToBack:self];
        }
    }];
    
    [UIView animateWithDuration:0.25f animations:^{
        _maskImageView.layer.transform = CATransform3DTranslate(t, 0, -30, -40);
        _maskImageView.layer.transform = CATransform3DRotate(t, 7/90.0 * M_PI_2, 1, 0, 0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            _maskImageView.layer.transform = CATransform3DTranslate(t, 0, 0, 0);
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }];
}

@end
