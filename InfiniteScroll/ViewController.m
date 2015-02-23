//
//  ViewController.m
//  InfiniteScroll
//
//  Created by Julian Alonso on 23/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "ViewController.h"
#import "ScrollOneView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScroll;

@property (nonatomic, strong) ScrollOneView *scrollView1;
@property (nonatomic, strong) ScrollOneView *scrollView2;
@property (nonatomic, strong) ScrollOneView *scrollView3;

@property (nonatomic, strong) NSArray *subViewColors;
@property (nonatomic, assign) CGFloat lastIndexOffset;
@property (nonatomic, assign) NSInteger actualIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAndShowMainScroll];
    [self loadColors];
    [self loadSubViewsAndAddToScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Init properties methods.
- (void)initAndShowMainScroll
{
    CGRect scrollFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.mainScroll = [[UIScrollView alloc] initWithFrame:scrollFrame];
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 3, CGRectGetHeight(self.view.bounds));
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.delegate = self;
    
   [self.view addSubview:self.mainScroll];
}

- (void)loadSubViewsAndAddToScroll
{
    CGFloat oneViewWidth = CGRectGetWidth(self.mainScroll.frame);
    CGFloat oneViewHeight = CGRectGetHeight(self.view.frame);
    
    CGRect view1Frame = CGRectMake(0, 0, oneViewWidth, oneViewHeight);
    
    CGRect view2Frame = CGRectMake(oneViewWidth, 0, oneViewWidth, oneViewHeight);
    
    CGRect view3Frame = CGRectMake(oneViewWidth * 2, 0, oneViewWidth, oneViewHeight);
    
    self.scrollView1 = [[ScrollOneView alloc] initWithFrame:view1Frame andBGColor:self.subViewColors[0]];
    self.scrollView2 = [[ScrollOneView alloc] initWithFrame:view2Frame andBGColor:self.subViewColors[1]];
    self.scrollView3 = [[ScrollOneView alloc] initWithFrame:view3Frame andBGColor:self.subViewColors[2]];
    
    [self.mainScroll addSubview:self.scrollView1];
    [self.mainScroll addSubview:self.scrollView2];
    [self.mainScroll addSubview:self.scrollView3];
    
    self.mainScroll.contentOffset = CGPointMake(oneViewWidth, 0);
    self.actualIndex = 1;
}

- (void)loadColors
{
    self.subViewColors = [NSArray arrayWithObjects:[UIColor grayColor], [UIColor greenColor], [UIColor blueColor], nil];
}

#pragma mark - ScrollViewDelegate methods.
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint middleViewOffset = CGPointMake(CGRectGetWidth(self.mainScroll.frame), 0);
    
    NSLog(@"End decelerating");
    NSLog(@"last index offset: %f", self.lastIndexOffset);
    NSLog(@"actual offset: %f", scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x == self.lastIndexOffset)
    {
        return;
    }
    
    if (scrollView.contentOffset.x < self.lastIndexOffset)
    {
        self.scrollView2.backgroundColor = self.scrollView1.backgroundColor;
        [self subtractionActualIndex];
    }
    else
    {
        self.scrollView2.backgroundColor = self.scrollView3.backgroundColor;
        [self sumActualIndex];
    }
    
    self.mainScroll.contentOffset = middleViewOffset;
    [self loadSideViews];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastIndexOffset = scrollView.contentOffset.x;
}

#pragma mark - Own methods.
- (void)loadSideViews
{
    if (self.actualIndex == 0)
    {
        self.scrollView1.backgroundColor = self.subViewColors[self.subViewColors.count -1];
        self.scrollView3.backgroundColor = self.subViewColors[self.actualIndex + 1];
    }
    else if (self.actualIndex == self.subViewColors.count -1)
    {
        self.scrollView1.backgroundColor = self.subViewColors[self.actualIndex -1];
        self.scrollView3.backgroundColor = self.subViewColors[0];
    }
    else
    {
        self.scrollView1.backgroundColor = self.subViewColors[self.actualIndex -1];
        self.scrollView3.backgroundColor = self.subViewColors[self.actualIndex +1];
    }
}

- (void)subtractionActualIndex
{
    if (self.actualIndex == 0)
    {
        self.actualIndex = self.subViewColors.count -1;
    }
    else
    {
        self.actualIndex--;
    }
}

- (void)sumActualIndex
{
    if (self.actualIndex == self.subViewColors.count -1)
    {
        self.actualIndex = 0;
    }
    else
    {
        self.actualIndex++;
    }
}

@end


