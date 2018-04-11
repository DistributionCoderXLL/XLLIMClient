//
//  XLLPageScrollController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLPageScrollController.h"
#import "XLLTagCell.h"
#import "XLLPageCell.h"

#define XLLCacheID @"XLLCacheID"

@interface XLLPageScrollController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//标签标题集合
@property (nonatomic, strong) NSMutableArray *tagTitleArray;
//class集合
@property (nonatomic, strong) NSMutableArray *pageClassArray;
//对应item存储class
@property (nonatomic, strong) NSMutableDictionary *controllersCaches;
//记录当前选中的tag位置
@property (nonatomic, assign) NSInteger selectedIndex;

//标签collectionView
@property (nonatomic, weak) UICollectionView *tagCollectionView;
//内容collectionView
@property (nonatomic, weak) UICollectionView *pageCollectionView;

@end

@implementation XLLPageScrollController
static NSString *const tagID = @"XLLTagCell";
static NSString *const pageID = @"XLLPageCell";

#pragma mark - lazy loading
- (NSMutableArray *)tagTitleArray
{
    if (_tagTitleArray == nil)
    {
        _tagTitleArray = [NSMutableArray array];
    }
    return _tagTitleArray;
}

- (NSMutableArray *)pageClassArray
{
    if (_pageClassArray == nil)
    {
        _pageClassArray = [NSMutableArray array];
    }
    return _pageClassArray;
}

- (NSMutableDictionary *)controllersCaches
{
    if (_controllersCaches == nil)
    {
        _controllersCaches = [NSMutableDictionary dictionary];
    }
    return _controllersCaches;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupBase];
    }
    return self;
}

- (void)setupBase
{
    UICollectionViewFlowLayout *tagLayout = [[UICollectionViewFlowLayout alloc] init];
    tagLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    tagLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    tagLayout.minimumLineSpacing = 30;
    tagLayout.minimumInteritemSpacing = 0;
    UICollectionView *tagCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:tagLayout];
    tagCollectionView.backgroundColor = [UIColor lightGrayColor];
    [tagCollectionView registerClass:NSClassFromString(tagID) forCellWithReuseIdentifier:tagID];
    tagCollectionView.delegate = self;
    tagCollectionView.dataSource = self;
    tagCollectionView.showsVerticalScrollIndicator = NO;
    tagCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tagCollectionView];
    self.tagCollectionView = tagCollectionView;
    
    
    UICollectionViewFlowLayout *pageLayout = [[UICollectionViewFlowLayout alloc] init];
    pageLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    pageLayout.sectionInset = UIEdgeInsetsZero;
    pageLayout.minimumLineSpacing = 0;
    pageLayout.minimumInteritemSpacing = 0;
    UICollectionView *pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:pageLayout];
    [pageCollectionView registerClass:NSClassFromString(pageID) forCellWithReuseIdentifier:pageID];
    pageCollectionView.delegate = self;
    pageCollectionView.dataSource = self;
    pageCollectionView.showsHorizontalScrollIndicator = NO;
    pageCollectionView.showsVerticalScrollIndicator = NO;
    pageCollectionView.pagingEnabled = YES;
    pageCollectionView.bounces = NO;
    [self.view addSubview:pageCollectionView];
    self.pageCollectionView = pageCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedIndex = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    });
}

#pragma mark - public method
- (void)reloadData:(NSArray *)titleArray subViewDisplayClasses:(NSArray *)classes
{
    [self.tagTitleArray removeAllObjects];
    [self.tagTitleArray addObjectsFromArray:titleArray];
    [self.pageClassArray removeAllObjects];
    [self.pageClassArray addObjectsFromArray:classes];
    [self.tagCollectionView reloadData];
    [self.pageCollectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isTagView:collectionView])
    {
        NSString *title = self.tagTitleArray[indexPath.item];
        CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.tagCollectionView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size.width;
        return CGSizeMake(width, self.tagCollectionView.frame.size.height);
    }
    return self.pageCollectionView.frame.size;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagTitleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isTagView:collectionView])
    {
        XLLTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tagID forIndexPath:indexPath];
        cell.tagStr = self.tagTitleArray[indexPath.item];
        cell.selected = (self.selectedIndex == indexPath.item);
        return cell;
    }
    XLLPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pageID forIndexPath:indexPath];
    UIViewController *cacheController = [self getCachedVCByIndexPath:indexPath];
    if (!cacheController)
    {
        Class currentClass = self.pageClassArray[indexPath.item];
        cacheController = [[currentClass alloc] init];
        [self saveCachedVC:cacheController ByIndexPath:indexPath];
    }
    [self addChildViewController:cacheController];
    [cell configCellWithVC:cacheController];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isTagView:collectionView])
    {
        //选中某个标签
        [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES];
        NSInteger gap = indexPath.item - self.selectedIndex;
        self.selectedIndex = indexPath.item;
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:labs(gap)>1?NO:YES];
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didSelectController:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)didSelectController:(CADisplayLink *)displayLink
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedIndex inSection:0];
    UIViewController *baseVC = [self getCachedVCByIndexPath:indexPath];
    if (baseVC) {
        [self didSelectControllerAtIndex:self.selectedIndex];
        [displayLink invalidate];
        displayLink = nil;
    }
}

- (void)didSelectControllerAtIndex:(NSInteger)index
{
    
}

- (RACSignal *)pageScrollSignal
{
    @weakify(self);
    RACSignal *changedTab=[self rac_signalForSelector:@selector(didSelectControllerAtIndex:)];
    return [[[[changedTab map:^id _Nullable(RACTuple *value) {
        @strongify(self);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[value.first integerValue] inSection:0];
        UIViewController *baseVC = [self getCachedVCByIndexPath:indexPath];
        if (!baseVC)
        {
            Class currentClass = self.pageClassArray[indexPath.item];
            baseVC = [[currentClass alloc] init];
            [self saveCachedVC:baseVC ByIndexPath:indexPath];
        }
        BOOL scrollEnable = [baseVC isKindOfClass:NSClassFromString(@"XLLBaseTBController")];
        if (!scrollEnable) return [NSNull null];
        id <XLLPageScrollDelegate> baseTBVC = (id <XLLPageScrollDelegate>)baseVC;
        return RACObserve(baseTBVC.tableView, contentOffset);
        /**
        id <XLLScrollDelegate> scrollVC = self.pageClassArray[[value.first integerValue]];
        BOOL scrollEnable = [scrollVC respondsToSelector:@selector(scrollView)];
        return scrollEnable?RACObserve(scrollVC.scrollView, contentOffset):[RACSignal return:[NSNull null]];
         */
    }] switchToLatest] filter:^BOOL(id  _Nullable value) {
       
        return [value isKindOfClass:[NSNull class]] || [value CGPointValue].y != 0;
    }] map:^id _Nullable(id  _Nullable value) {
        
        if ([value isKindOfClass:[NSNull class]]) return value;
        @strongify(self);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedIndex inSection:0];
        id <XLLPageScrollDelegate> baseTBVC = (id <XLLPageScrollDelegate>)[self getCachedVCByIndexPath:indexPath];
        return baseTBVC.tableView;
    }];
}

#pragma - mark UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.pageCollectionView) {
        
        int index = scrollView.contentOffset.x / self.pageCollectionView.frame.size.width;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - 模拟重用机制
- (UIViewController *)getCachedVCByIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cachedDic = [self.controllersCaches objectForKey:@(indexPath.item)];
    UIViewController *cachedController = [cachedDic objectForKey:XLLCacheID];
    return cachedController;
}

- (void)saveCachedVC:(UIViewController *)viewController ByIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *newCacheDic = @{
                                  XLLCacheID:viewController
                                  };
    [self.controllersCaches setObject:newCacheDic forKey:@(indexPath.item)];
}

// 判断是否为tagCollectionView
- (BOOL)isTagView:(UICollectionView *)collectionView
{
    if ([collectionView isEqual:self.tagCollectionView])
    {
        return YES;
    }
    return NO;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tagCollectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
    self.pageCollectionView.frame = CGRectMake(0, CGRectGetMaxY(self.tagCollectionView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.tagCollectionView.frame));
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
