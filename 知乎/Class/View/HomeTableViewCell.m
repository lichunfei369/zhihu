//
//  HomeTableViewCell.m
//  知乎
//
//  Created by 李春菲 on 2018/1/8.
//  Copyright © 2018年 李春菲. All rights reserved.
//

#import "HomeTableViewCell.h"
@interface HomeTableViewCell()
@property  (nonatomic,strong) UILabel * titleLabel;
@property  (nonatomic,strong) UIImageView * iconImageViewe;
@property  (nonatomic,strong) UIView * bgView;
@end

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creabgView];
        self.titleLabel = [UILabel new];
        [self.bgView addSubview:self.titleLabel];
        self.iconImageViewe = [UIImageView new];
        [self.bgView addSubview:self.iconImageViewe];
        self.iconImageViewe.sd_layout.topSpaceToView(self.bgView, 10).leftSpaceToView(self.bgView, 10).widthIs(70).heightIs(60);
        self.titleLabel.sd_layout.topEqualToView(self.iconImageViewe).leftSpaceToView(self.iconImageViewe, 10).rightSpaceToView(self.bgView, 10).autoHeightRatio(0);
        [self.bgView setupAutoHeightWithBottomViewsArray:@[self.iconImageViewe,self.titleLabel] bottomMargin:10];
        [self setupAutoHeightWithBottomViewsArray:@[self.bgView,] bottomMargin:5];
    }
    return self;
}

- (void)creabgView{
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.shadowOffset = CGSizeMake(1, 1);
    self.bgView.layer.shadowOpacity = 0.3;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:self.bgView];
    self.bgView.sd_layout.topSpaceToView(self.contentView, 10).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10);
}
- (void)setHomeModel:(HomeModelJson *)homeModel {
    
    _homeModel = homeModel;
    self.titleLabel.text = homeModel.title;
    [self.iconImageViewe sd_setImageWithURL:[NSURL URLWithString:homeModel.images.firstObject]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.bgView.backgroundColor = [UIColor whiteColor];
    if (selected) {
        self.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }else {
        self.bgView.backgroundColor = [UIColor whiteColor];
        
    }
}

@end
