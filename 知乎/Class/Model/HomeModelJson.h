//
//  HomeModel.h
//  知乎
//
//  Created by 李春菲 on 2018/1/8.
//  Copyright © 2018年 李春菲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModelJson : NSObject
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,copy) NSString  * title;
@property (nonatomic,copy) NSString * ga_prefix;
@property (nonatomic,assign) long long id;
@property (nonatomic,assign) NSInteger type;
@end
