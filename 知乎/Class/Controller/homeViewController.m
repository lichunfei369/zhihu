//
//  ViewController.m
//  知乎
//
//  Created by 李春菲 on 2018/1/7.
//  Copyright © 2018年 李春菲. All rights reserved.
//

#import "homeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModelJson.h"
#import "HomeModelArray.h"
#import "PictureView.h"
#define IDENTIF  @"homeCell"
@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView  * tableView;
@property (nonatomic,strong) NSMutableArray  *dataArray;
@property  (nonatomic,strong) PictureView *  pictureView;
@property  (nonatomic,strong) HomeModelArray *  homeModelArray;
@end

@implementation homeViewController
#pragma 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:IDENTIF];
        
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
    
}
- (PictureView *)pictureView {
    if (!_pictureView) {
        _pictureView = [[PictureView alloc]init];
        _pictureView.frame = CGRectMake(0, 0,SCREEN_WITH, 240);
    }
    return _pictureView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pictureView];
    [self  httpShareManage];
}

#pragma mark - 获取新闻数据
- (void)httpShareManage {
    [[AFHTTPSessionManager manager] GET:@"https://news-at.zhihu.com/api/4/news/latest" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HomeModelArray mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"stories":@"HomeModelJson",
                     @"top_stories":@"PicturesModel"
                     };
        }];
        HomeModelArray * model = [HomeModelArray mj_objectWithKeyValues:responseObject];
        self.dataArray  = model.stories.mutableCopy;
        self.homeModelArray = model;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IDENTIF];
    cell.homeModel = self.dataArray[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"homeModel" cellClass:[HomeTableViewCell class] contentViewWidth:self.view.frame.size.width];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
 
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat yOffset = self.tableView.contentOffset.y;
        if (yOffset <= 0) {
            self.pictureView.height = 220 - yOffset;
            CGRect frame = self.pictureView.frame;
            frame.origin.y = 0;
            self.pictureView.frame = frame;
        }else{
            CGRect frame = self.pictureView.frame;
            frame.origin.y = 0 - yOffset;
            self.pictureView.frame = frame;
        }
    }
}
#pragma mark - Setting
//- (void)setDataArray:(NSMutableArray *)dataArray {
//    _dataArray = dataArray;
//    [self.tableView reloadData];
//}
- (void)setHomeModelArray:(HomeModelArray *)homeModelArray{
    _homeModelArray = homeModelArray;
    self.pictureView.imageViewArray = homeModelArray.top_stories;
       [self.tableView reloadData];
}

//观察者用过之后要删除观察对象
- (void)dealloc {
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
