//
//  DetailViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "DetailViewController.h"
#import "JDInteractiveTransition.h"
#import "DetailBottomView.h"
#import "DesignModel.h"
#import "PhotographyModel.h"

typedef enum {
    PageTypeDesign,
    PageTypePhotography
}PageType;

@interface DetailViewController ()<UIViewControllerTransitioningDelegate,DetailBottomViewDelegate>

@property (nonatomic, strong) JDInteractiveTransition *transition;

@property (nonatomic, assign) PageType pageType;
@property (nonatomic, strong) DesignModel *designModel;
@property (nonatomic, strong) PhotographyModel *photographyModel;

@property (nonatomic, strong) UIButton *dismissBtn;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) DetailBottomView *bottomView;

@end

@implementation DetailViewController

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        self.transition.transitionStyle = JDTransitionStyleExpand;
        self.transition.resources = model;
        if ([model isKindOfClass:[DesignModel class]]) {
            _pageType = PageTypeDesign;
            _designModel = model;
            self.transition.mainImage = [UIImage imageWithData:_designModel.mainImg];
        } else if ([model isKindOfClass:[PhotographyModel class]]) {
            _pageType = PageTypePhotography;
            _photographyModel = model;
            self.transition.mainImage = [UIImage imageWithData:_photographyModel.mainImg];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubviews];
}

- (void)setUpSubviews {
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topImageView.clipsToBounds = YES;
    [self.view addSubview:self.topImageView];
    
    self.dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    self.dismissBtn.backgroundColor = [UIColor whiteColor];
    self.dismissBtn.layer.cornerRadius = 15;
    self.dismissBtn.layer.masksToBounds = YES;
    self.dismissBtn.transform = CGAffineTransformMakeRotation(-M_PI/2);
    [self.dismissBtn addTarget:self action:@selector(dismissBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissBtn];
    
    switch (_pageType) {
        case PageTypeDesign:
            self.topImageView.image = [UIImage imageWithData:_designModel.mainImg];
            self.bottomView = [[DetailBottomView alloc] initWithResources:_designModel];
            break;
        case PageTypePhotography:
            self.topImageView.image = [UIImage imageWithData:_photographyModel.mainImg];
            self.bottomView = [[DetailBottomView alloc] initWithResources:_photographyModel];
            break;
    }
    self.bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
}

- (void)viewWillLayoutSubviews {
    [_dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.width.height.mas_equalTo(30);
    }];
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.frame.size.height/2+40);
    }];
    
//    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view);
//        make.top.equalTo(_topImageView.mas_bottom);
//    }];
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.topImageView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topImageView.frame));
}

- (void)dismissBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setStartFrame:(CGRect)startFrame {
    _startFrame = startFrame;
    self.transition.startFrame = startFrame;
}

#pragma mark - bottom delegate
- (void)bottomView:(DetailBottomView *)bottomView didClickExpandBtnOfType:(ExpandButtonType)buttonType {
    if (buttonType == ExpandButtonTypeClose) {
        [UIApplication sharedApplication].statusBarHidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            bottomView.frame = self.view.bounds;
        }];
    } else if (buttonType == ExpandButtonTypeOpen) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.topImageView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topImageView.frame));
        }];
    }
}

#pragma mark - transition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transition.type = JDTransitionTypePresent;
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transition.type = JDTransitionTypeDismiss;
    return self.transition;
}

- (JDInteractiveTransition *)transition {
    if (!_transition) {
        _transition = [[JDInteractiveTransition alloc] init];
    }
    return _transition;
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
