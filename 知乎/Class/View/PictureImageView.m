//
//  PictureImageView.m
//  知乎
//
//  Created by 李春菲 on 2018/1/8.
//  Copyright © 2018年 李春菲. All rights reserved.
//

#import "PictureImageView.h"
@interface  PictureImageView()
@property  (nonatomic,strong) UILabel * titleLabel;
@end

@implementation PictureImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill; //防止挤压变形  设置图片填充
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
      
        self.titleLabel.sd_layout.centerXEqualToView(self).rightSpaceToView(self, 25).leftSpaceToView(self, 25).bottomSpaceToView(self, 35).autoHeightRatio(0);
    }
    return self;
}

- (void)setPictureModel:(PicturesModel *)PictureModel {
    _PictureModel = PictureModel;
    [self sd_setImageWithURL:[NSURL URLWithString:PictureModel.image]];
    self.titleLabel.text = PictureModel.title;
}

@end
