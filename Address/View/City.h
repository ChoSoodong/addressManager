//
//  City.h
//  TasteFresh
//
//  Created by ZHAO on 2018/1/16.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic ,strong) NSString * cityName;/**< 城市名*/

@property (nonatomic ,strong) NSArray  * areas;/**< 城市包含的所有地区*/


/**
 *  初始化城市
 *
 *  @param name  城市名字
 *  @param areas 城市包含的地区
 *
 *  @return 初始化城市
 */
- (instancetype)initWithName:(NSString *)name
                       areas:(NSArray *)areas;

/**
 *  初始化城市
 *
 *  @param cityName 城市名字
 *  @param areas    城市包含的地区
 *
 *  @return 初始化城市
 */
+ (instancetype)cityWithName:(NSString *)cityName
                       areas:(NSArray *)areas;


@end
