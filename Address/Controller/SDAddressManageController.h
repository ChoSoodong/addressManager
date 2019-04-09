//
//  MTAddressManageController.h
//  TasteFresh
//
//  Created by ZHAO on 2018/1/19.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAddressModel.h"

@class SDAddressManageController;

@protocol SDAddressManageControllerDelegate<NSObject>

//默认按钮点击代理方法
-(void)addressManageControllerDefaultButtonClick:(SDAddressManageController *)addressVC addressModel:(MTAddressModel *)addressModel;

@end

@interface SDAddressManageController : SDBaseController

//导航栏标题
@property (nonatomic, copy) NSString *navigationTitle;

//代理属性
@property (nonatomic, weak) id<SDAddressManageControllerDelegate> delegate;

@end
