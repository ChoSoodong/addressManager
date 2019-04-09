//
//  MTAddressModel.h
//  TasteFresh
//
//  Created by ZHAO on 2018/2/1.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//
//地址模型
#import <Foundation/Foundation.h>

@interface MTAddressModel : NSObject

//地址编号
@property (nonatomic, copy) NSString *address_no;

//是否为默认地址
@property (nonatomic, assign) BOOL is_default;

//省市
@property (nonatomic, copy) NSString *address_area;

//详细地址
@property (nonatomic, copy) NSString *address_detail;

//收货人
@property (nonatomic, copy) NSString *recv_name;

//收货人电话
@property (nonatomic, copy) NSString *recv_tel;

@end
