//
//  MainTabBarController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MainTabBarController.h"

#import "DesignViewController.h"
#import "PhotoGraphyViewController.h"
#import "AboutViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
        
        
        
        //显示未读
        UINavigationController  *discoverNav =(UINavigationController *)self.viewControllers[1];
        UITabBarItem *curTabBarItem=discoverNav.tabBarItem;
        [curTabBarItem setBadgeValue:@"2"];
    }
    return self;
}


- (void)setupTabBarController {
    //设置tabBar默认和选中颜色
    NSMutableDictionary *normalAtts = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedAtts = [NSMutableDictionary dictionary];
    normalAtts[NSForegroundColorAttributeName] = RGB(195, 195, 195);
    selectedAtts[NSForegroundColorAttributeName] = RGB(0, 0, 0);
    [[UITabBarItem appearance] setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    
    // 设置TabBar属性数组
    self.tabBarItemsAttributes =[self tabBarItemsAttributesForController];
    
    // 设置控制器数组
    self.viewControllers =[self mpViewControllers];
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}


//控制器设置
- (NSArray *)mpViewControllers {
    DesignViewController *designViewController = [[DesignViewController alloc] init];
    UINavigationController *firstNavigationController = [[MainNavigationController alloc]
                                                         initWithRootViewController:designViewController];
    
    PhotoGraphyViewController *photoGraphyViewController = [[PhotoGraphyViewController alloc] init];
    UINavigationController *secondNavigationController = [[MainNavigationController alloc]
                                                          initWithRootViewController:photoGraphyViewController];
    
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    UINavigationController *thirdNavigationController = [[MainNavigationController alloc]
                                                         initWithRootViewController:aboutViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    return viewControllers;
}

//TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"DESIGN",
                                                 CYLTabBarItemImage : @"",
                                                 CYLTabBarItemSelectedImage : @"",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"PHOTOGRAPHY",
                                                  CYLTabBarItemImage : @"",
                                                  CYLTabBarItemSelectedImage : @"",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"ABOUT",
                                                 CYLTabBarItemImage : @"",
                                                 CYLTabBarItemSelectedImage : @"",
                                                 };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}


#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
    /// 特殊处理 - 是否需要登录
//    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[MPDiscoveryViewController class]];
//    if (isBaiDuService) {
//        NSLog(@"你点击了TabBar第二个");
//    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
