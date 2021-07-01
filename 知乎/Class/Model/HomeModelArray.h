//
//  HomeModelArray.h
//  知乎
//
//  Created by 李春菲 on 2018/1/8.
//  Copyright © 2018年 李春菲. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeModelJson;
@interface HomeModelArray : NSObject
@property   (nonatomic,copy)    NSString * date;
@property   (nonatomic,strong)  NSArray<HomeModelJson *> * stories;
@property   (nonatomic,strong)  NSArray  * top_stories;

@end
