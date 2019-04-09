//
//  City.m
//  TasteFresh
//
//  Created by ZHAO on 2018/1/16.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//

#import "City.h"

@implementation City

- (instancetype)initWithName:(NSString *)name
                       areas:(NSArray *)areas{
    if (self = [super init]) {
        _cityName = name;
        _areas = areas;
    }
    return self;
}

+ (instancetype)cityWithName:(NSString *)cityName
                       areas:(NSArray *)areas{
    City * city = [[City alloc]initWithName:cityName
                                      areas:areas];
    return city;
}

@end
