//
//  PictureView.m
//  知乎
//
//  Created by 李春菲 on 2018/1/8.
//  Copyright © 2018年 李春菲. All rights reserved.
//

#import "PictureView.h"
#import "PicturesModel.h"
#import "PictureImageView.h"
@interface PictureView()
@property (nonatomic,strong) UIScrollView * scrollerView;
@property (nonatomic,strong) UIPageControl * pageController;
@property (nonatomic,strong) NSMutableArray * imageDate;
@property (nonatomic,strong) NSTimer *timer;
@end
@implementation PictureView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView * scrollerView = [UIScrollView new];
        scrollerView.pagingEnabled = YES; //设置整块滚动
        scrollerView.bounces = NO;
        scrollerView.delegate = self;
        [self addSubview:scrollerView];
        self.scrollerView = scrollerView;
        
        UIPageControl * page = [UIPageControl new];
        [self addSubview:page];
        self.pageController = page;
        
        scrollerView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
        page.sd_layout.centerXEqualToView(self).widthIs(60).heightIs(15).bottomSpaceToView(self, 10);
    }
    
    return self;
}

- (void)setImageViewArray:(NSArray *)imageViewArray {
    
    _imageViewArray = imageViewArray;
    self.pageController.numberOfPages = imageViewArray.count; //页数多少
    for (PicturesModel * model in imageViewArray) {
        PictureImageView * imageview = [[PictureImageView alloc]init];
        imageview.PictureModel = model;
      
        [self.scrollerView addSubview:imageview];
        if (self.imageDate.count == 0) {
            imageview.sd_layout.topSpaceToView(self.scrollerView,0).leftSpaceToView(self.scrollerView,0).bottomSpaceToView(self.scrollerView, 0).widthRatioToView(self.scrollerView,1);
        }else{
              imageview.sd_layout.topSpaceToView(self.scrollerView,0).leftSpaceToView([self.imageDate lastObject],0).bottomSpaceToView(self.scrollerView, 0).widthRatioToView(self.scrollerView,1);
        }
         [self.imageDate addObject:imageview];//  这里是先添加到数组之后再进行轮播张数的操作
        self.scrollerView.contentSize = CGSizeMake(self.imageViewArray.count *self.width, self.height);
    }
    
    [self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xoffset = scrollView.contentOffset.x;  //拿到scorllview滚动到哪里
    int currenPage = (int)(xoffset / self.width + 0.5);  //如果不加0.5  xoffset的值是0  0除以任何数都是0 强转成整数类型
    self.pageController.currentPage = currenPage;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self addTimer];
}
/**
 Timer
 添加之后要关闭计时器防止内存泄漏
 */
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
- (void)removeTimer{
    [self.timer invalidate];
  
}
- (void)nextImage{
    
    NSInteger page = (self.pageController.currentPage +1) % self.pageController.numberOfPages;
    CGFloat xoffset = page * self.width;
    [self.scrollerView setContentOffset:(CGPointMake(xoffset, 0)) animated:YES];
}

-(NSMutableArray *)imageDate {
    if (!_imageDate) {
        _imageDate = [NSMutableArray array];
    }
    return _imageDate;
}
@end
