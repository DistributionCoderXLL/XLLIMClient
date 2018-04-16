//
//  XLLUserController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLUserController.h"
#import "XLLSubPageController.h"
#import "XLLPageScrollView.h"
#import "XLLUserNavView.h"
#import "XLLCarouselView.h"
#import "UIImage+XLL.h"
#import "UIView+XLLRefresh.h"

#define XLLCarouselHeight 170.0

@interface XLLUserController () <UIScrollViewDelegate>

@property (nonatomic, weak) XLLPageScrollView *pageScrollView;
@property (nonatomic, weak) XLLUserNavView *userNavView;
@property (nonatomic, weak) XLLCarouselView *carouselView;
@property (nonatomic, strong) XLLSubPageController *subPageVC;

@end

@implementation XLLUserController

#pragma mark - lazy load
- (XLLSubPageController *)subPageVC
{
    if (_subPageVC == nil)
    {
        _subPageVC = [[XLLSubPageController alloc] init];
    }
    return _subPageVC;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubViews];
    [self setupRefreshView];
    [self setupRACSingle];
}

- (void)setupRACSingle
{
    // 当前子ScrollView偏移量信号
    RACSignal *currentSubScrollOffset = self.subPageVC.pageScrollSignal;
    @weakify(self);
    [[currentSubScrollOffset filter:^BOOL(id  _Nullable value) {
        
        return [value isKindOfClass:[UIScrollView class]];
    }] subscribeNext:^(UIScrollView *subScrollView) {
        
        @strongify(self);
        CGFloat offsetY = MAX(0, self.pageScrollView.contentOffset.y + subScrollView.contentOffset.y);
        if (offsetY < XLLCarouselHeight - 64) {
            subScrollView.contentOffset = CGPointZero;
        } else {
            self.pageScrollView.contentOffset = CGPointMake(0, XLLCarouselHeight - 64);
        }
    }];
}

- (void)setupRefreshView
{
    __weak typeof(self)weakSelf = self;
    [self.view refreshWithScrollView:self.pageScrollView refreshBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.view endXLLRefresh];
        });
    }];
}

- (void)setupSubViews
{
    XLLPageScrollView *pageScrollView = [[XLLPageScrollView alloc] init];
    pageScrollView.showsVerticalScrollIndicator = NO;
    pageScrollView.delegate = self;
    [self.view addSubview:pageScrollView];
    self.pageScrollView = pageScrollView;
    if (@available(iOS 11.0, *)) {
        pageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    XLLCarouselView *carouselView = [[XLLCarouselView alloc] init];
    [self.pageScrollView addSubview:carouselView];
    self.carouselView = carouselView;
    
    XLLUserNavView *userNavView = [[XLLUserNavView alloc] init];
    [self.view addSubview:userNavView];
    self.userNavView = userNavView;
    
    [self addChildViewController:self.subPageVC];
    [self.subPageVC didMoveToParentViewController:self];
    [self.pageScrollView addSubview:self.subPageVC.view];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:self.pageScrollView]) return;
    if (scrollView.contentOffset.y >= XLLCarouselHeight - 64) {
        scrollView.contentOffset = CGPointMake(0, XLLCarouselHeight - 64);
    }
    if (scrollView.contentOffset.y <= 0)
    {
        self.userNavView.bgAlpha = 0;
        self.carouselView.y = scrollView.contentOffset.y;
        self.carouselView.height = -scrollView.contentOffset.y + XLLCarouselHeight;
    } else {
        self.userNavView.bgAlpha = (fabs(scrollView.contentOffset.y + 64)) / XLLCarouselHeight;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.userNavView.frame = XLLCGM(0, 0, UI_SCREEN_WIDTH, 64);
    self.pageScrollView.frame = self.view.bounds;
    self.pageScrollView.contentSize = CGSizeMake(self.view.width, self.view.height + XLLCarouselHeight);
    self.carouselView.frame = XLLCGM(0, 0, self.pageScrollView.width, XLLCarouselHeight);
    self.subPageVC.view.frame = XLLCGM(0, XLLCarouselHeight, self.pageScrollView.width, self.pageScrollView.height);
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

