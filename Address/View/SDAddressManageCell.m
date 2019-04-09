






//地址管理 cell
#import "SDAddressManageCell.h"
#import "SDEditAddressController.h"     //编辑地址

@interface SDAddressManageCell()

/** 背景 */
@property (nonatomic, strong)  UIView *bgView;
/** 姓名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 手机号 */
@property (nonatomic, strong) UILabel *phoneLabel;
/** 地址 */
@property (nonatomic, strong) UILabel *addressLabel;
/** line */
@property (nonatomic, strong) UIView *lineView;
/** 默认地址按钮 */
@property (nonatomic, strong) UIButton *defaultButton;
/** 删除 */
@property (nonatomic, strong) UIButton *deleteButton;
/** 编辑 */
@property (nonatomic, strong) UIButton *editButton;


@property (nonatomic, strong)  SDEditAddressController *editAddressVC;

@end

@implementation SDAddressManageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(KScaleW(8));
            make.right.bottom.offset(-KScaleW(8));
        }];
        
        //姓名
        _nameLabel = [UILabel labelWithTextColor:KTitleColor andTextFontSize:AdjustFont(14) andNumblerOfLines:1 andText:@"姓名"];
        [_bgView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(KScaleW(8));
            
        }];
        
        //手机号
        _phoneLabel = [UILabel labelWithTextColor:KTitleColor andTextFontSize:AdjustFont(14) andNumblerOfLines:1 andText:@"15700001111"];
        [_bgView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel).offset(0);
            make.left.equalTo(self.nameLabel.mas_right).offset(KScaleW(24));
            
        }];
        
        //地址
        _addressLabel = [UILabel labelWithTextColor:RGB(102, 102, 102) andTextFontSize:AdjustFont(12) andNumblerOfLines:2 andText:@"天津市西青区大寺镇佳和雅庭1234号"];
        [_bgView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.phoneLabel.mas_bottom).offset(KScaleH(8));
            make.left.offset(KScaleW(8));
            make.right.offset(-KScaleW(8));
            
        }];
        
        //分割线
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(238, 238, 238);
        [_bgView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom).offset(KScaleH(16));
            make.left.right.offset(0);
            make.height.offset(1);
        }];
        
        //默认地址按钮
        _defaultButton = [[UIButton alloc] init];
        _defaultButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFont(14)];
        [_defaultButton setImage:[UIImage imageNamed:@"addressIcons.bundle/address_select_nor"] forState:UIControlStateNormal];
        [_defaultButton setImage:[UIImage imageNamed:@"addressIcons.bundle/address_select_sel"] forState:UIControlStateSelected];
        [_defaultButton setTitle:@" 设为默认地址" forState:UIControlStateNormal];
        [_defaultButton setTitle:@" 设为默认地址" forState:UIControlStateSelected];
        [_defaultButton setTitleColor:KTitleColor forState:UIControlStateNormal];
        [_defaultButton addTarget:self action:@selector(defaultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_defaultButton];
        [_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(KScaleH(8));
            make.left.equalTo(self.nameLabel.mas_left).offset(0);
        }];
        
        
        //删除按钮
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteButton setImage:[UIImage imageNamed:@"addressIcons.bundle/address_delete_icon"] forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"addressIcons.bundle/address_delete_icon"] forState:UIControlStateHighlighted];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        [_deleteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_bgView addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.defaultButton).offset(0);
            make.right.offset(-KScaleW(8));
        }];
        
        //编辑按钮
        _editButton = [[UIButton alloc] init];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFont(14)];
        [_editButton setImage:[UIImage imageNamed:@"addressIcons.bundle/edit_icon"] forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"addressIcons.bundle/edit_icon"] forState:UIControlStateHighlighted];
        [_editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _editButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        [_editButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_bgView addSubview:_editButton];
        [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.defaultButton).offset(0);
            make.right.equalTo(self.deleteButton.mas_left).offset(-KScaleW(16));
            make.bottom.offset(-KScaleH(8));
        }];
    }
    return self;
}


#pragma mark - 默认按钮点击方法
-(void)defaultButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    
    if ([self.delegate respondsToSelector:@selector(addressManageCellButtonClick:defaultButton:)]) {
        [self.delegate addressManageCellButtonClick:self defaultButton:button];
    }
    
}

#pragma mark - 删除按钮点击事件
-(void)deleteButtonClick:(UIButton *)button{
    
    NSLog(@"删除按钮");
    
    if ([self.delegate respondsToSelector:@selector(addressManageCellButtonClick:deleteButton:)]) {
        [self.delegate addressManageCellButtonClick:self deleteButton:button];
    }
}

-(void)setAddressModel:(MTAddressModel *)addressModel{
    _addressModel = addressModel;
    
    _nameLabel.text = addressModel.recv_name;
    _phoneLabel.text = [NSString replaceStringWithOriginalStr:addressModel.recv_tel startLocation:3 length:4 withReplaceStr:@"*"];
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@",addressModel.address_area,addressModel.address_detail];
    _defaultButton.selected = addressModel.is_default;
    
}


#pragma mark - 编辑按钮点击事件
-(void)editButtonClick{
    
    _editAddressVC = [[SDEditAddressController alloc] init];
    _editAddressVC.addressModel = self.addressModel;
    [self.viewController.navigationController pushViewController:_editAddressVC animated:YES];
    
}
@end
