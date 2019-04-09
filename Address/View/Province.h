//
//  Province.h
//  TasteFresh
//
//  Created by ZHAO on 2018/1/16.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//
//  省份模型

#import <Foundation/Foundation.h>
#import "City.h"


@interface Province : NSObject
@property (nonatomic, strong) NSString       * name;/**< 省名字*/
@property (nonatomic, strong) NSArray        * cities;/**< 该省包含的所有城市名称*/
@property (nonatomic, strong) NSMutableArray * cityModels;/**< 该省包含的所有城市模型*/


/**
 *  初始化省份
 *
 *  @param name   省名字
 *  @param cities 省包含的所有城市名字
 *
 *  @return 初始化省份
 */
- (instancetype)initWithName:(NSString *)name
                      cities:(NSArray *)cities;

/**
 *  初始化省份
 *
 *  @param name   省名字
 *  @param cities 省包含的所有城市名字
 *
 *  @return 初始化省份
 */
+ (instancetype)provinceWithName:(NSString *)name
                          cities:(NSArray *)cities;



@end
