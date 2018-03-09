//
//  SYGuideView.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/9.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYGuideViewController.h"
#import "SYGuideViewCell.h"

static NSString *SYGuideViewCellID = @"SYGuideViewCellID";

@interface SYGuideViewController()
<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *cView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SYGuideViewController

- (NSMutableArray *)guideImages {
    if (!_guideImages) {
        _guideImages = [NSMutableArray array];
    }
    return _guideImages;
}

- (void)show:(BOOL)rootViewController {
    if (!rootViewController) {
        self.pageControl.numberOfPages = self.guideImages.count;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self.view addSubview:self.cView];
        [self.view addSubview:self.pageControl];
        [window addSubview:self.view];
    }
    else {
        self.pageControl.numberOfPages = self.guideImages.count;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self.view addSubview:self.cView];
        [self.view addSubview:self.pageControl];
        [window setRootViewController:self];
    }
}

/**
 *  引导页界面
 *
 *  @return 引导页界面
 */
- (UICollectionView *)cView {
    if (!_cView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = kGuideViewBounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _cView = [[UICollectionView alloc] initWithFrame:kGuideViewBounds collectionViewLayout:layout];
        _cView.bounces = NO;
        _cView.backgroundColor = [UIColor whiteColor];
        _cView.showsHorizontalScrollIndicator = NO;
        _cView.showsVerticalScrollIndicator = NO;
        _cView.pagingEnabled = YES;
        _cView.dataSource = self;
        _cView.delegate = self;
        
        [_cView registerClass:[SYGuideViewCell class] forCellWithReuseIdentifier:SYGuideViewCellID];
    }
    return _cView;
}

/**
 *  初始化pageControl
 *  @return pageControl
 */
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 0, kGuideViewBounds.size.width, 44.0f);
        _pageControl.center = CGPointMake(kGuideViewBounds.size.width / 2, kGuideViewBounds.size.height - 44);
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.guideImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SYGuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SYGuideViewCellID forIndexPath:indexPath];
    
    UIImage *img = [UIImage imageNamed:[self.guideImages objectAtIndex:indexPath.row]];
    CGSize size = [self adapterSizeImageSize:img.size compareSize:kGuideViewBounds.size];
    
    //自适应图片位置,图片可以是任意尺寸,会自动缩放.
    cell.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    cell.imageView.image = img;
    cell.imageView.center = CGPointMake(kGuideViewBounds.size.width / 2, kGuideViewBounds.size.height / 2);
    
    if (indexPath.row == self.guideImages.count - 1) {
        cell.guideBtnBottonOffset = self.guideBtnBottonOffset;
        cell.btn = self.guideBtn;
    }
    
    return cell;
}

/**
 *  计算自适应的图片
 *  @param is 需要适应的尺寸
 *  @param cs 适应到的尺寸
 *  @return 适应后的尺寸
 */
- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs
{
    CGFloat w = cs.width;
    CGFloat h = cs.width / is.width * is.height;
    
    if (h < cs.height) {
        w = cs.height / h * w;
        h = cs.height;
    }
    return CGSizeMake(w, h);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger currentPage = (scrollView.contentOffset.x / kGuideViewBounds.size.width);
    if (currentPage == self.guideImages.count - 1) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    self.pageControl.currentPage = currentPage;
}

/**
 *  移除所有界面
 */
- (void)removeAllViews {
    [self.pageControl removeFromSuperview];
    [self.cView removeFromSuperview];
    self.cView = nil;
    [self setPageControl:nil];
}

@end
