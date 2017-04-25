//
//  GuideViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "GuideViewController.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"

@interface GuideViewController ()

@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setUpSubviews {
    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gifImage.gif" ofType:nil]]];
    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:gifImageView];
    self.gifImageView = gifImageView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"进入首页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 2;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
}

- (void)viewWillLayoutSubviews {
    [_gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-150);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}

- (void)btnClick {
    [(AppDelegate *)[UIApplication sharedApplication].delegate setMainTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
