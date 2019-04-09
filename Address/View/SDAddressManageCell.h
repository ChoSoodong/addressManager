//
//  MTAddressManageCell.h
//  TasteFresh
//
//  Created by ZHAO on 2018/1/19.
//  Copyright © 2018年 XiaLanTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAddressModel.h"

@class SDAddressManageCell;

@protocol SDAddressManageCellDelegate<NSObject>

//删除按钮点击代理方法
-(void)addressManageCellButtonClick:(SDAddressManageCell *)cell deleteButton:(UIButton *)button;

//默认按钮点击代理方法
-(void)addressManageCellButtonClick:(SDAddressManageCell *)cell defaultButton:(UIButton *)button;

@end

@interface SDAddressManageCell : UITableViewCell

//代理属性
@property (nonatomic, weak) id<SDAddressManageCellDelegate> delegate;

//模型属性
@property (nonatomic, strong) MTAddressModel *addressModel;

@end
