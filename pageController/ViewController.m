//
//  ViewController.m
//  pageController
//
//  Created by 毛毛 on 16/9/10.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "ViewController.h"
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RandColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1)

@interface ViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong)UIPageViewController *pageViewController;
@property (nonatomic, strong)NSMutableArray *selectedArr;
@property (nonatomic, strong)NSMutableArray *viewArr;
@end

@implementation ViewController
#pragma mark - 懒加载
- (NSMutableArray *)selectedArr
{
    if (!_selectedArr) {
        NSArray *arr = @[@"全部", @"女性专区", @"90后专区", @"女装", @"男装", @"裙子", @"鞋子", @"儿童", @"箱包", @"内衣", @"母婴", @"美妆", @"美食", @"百货", @"家纺", @"数码", @"电器", @"文体", @"配饰", @"运动", @"汽车"];
        _selectedArr = [NSMutableArray arrayWithArray:arr];
    }
    return _selectedArr;
}
- (NSMutableArray *)viewArr
{
    if (!_viewArr) {
        _viewArr = [NSMutableArray array];
    }
    return _viewArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                              options:nil]];
    
    for (UIView *view in [[[self pageViewController] view] subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setCanCancelContentTouches:YES];
            [(UIScrollView *)view setDelaysContentTouches:NO];
        }
    }
    
    [[self pageViewController] setDataSource:self];
    [[self pageViewController] setDelegate:self];
    
    [[[self pageViewController] view] setFrame:CGRectMake(0, 74, MainScreenWidth, MainScreenHeight-74)];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    for (int i = 0; i<self.selectedArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = RandColor;
        [self.viewArr addObject:vc];
    }

    [self.view sendSubviewToBack:_pageViewController.view];
    [self.pageViewController setViewControllers:@[[self viewArr][0]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];

}

#pragma mark - Page View Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = [[self viewArr] indexOfObject:viewController];
    return pageIndex > 0 ? [self viewArr][pageIndex - 1]: nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger pageIndex = [[self viewArr] indexOfObject:viewController];
    return pageIndex < [[self viewArr] count] - 1 ? [self viewArr][pageIndex + 1]: nil;
}

#pragma mark - Page View Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
//    NSInteger index = [[self viewArr] indexOfObject:pendingViewControllers[0]];
   
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}

@end
