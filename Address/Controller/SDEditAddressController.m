






//编辑/新增地址
#import "SDEditAddressController.h"
#import "AddressPickerView.h"    //地址选择器

#define WIDTH_LAB KScaleW(70)

@interface SDEditAddressController ()<UITextFieldDelegate,
                                        AddressPickerViewDelegate,
                                        UITextViewDelegate>

//收货人
@property (nonatomic, weak) UITextField *consigneeTF;

//联系电话
@property (nonatomic, weak) UITextField *phoneNumTF;

//所在地区
@property (nonatomic, weak) UILabel *areaLabel;

//详细地址
@property (nonatomic, weak) UITextView *detailAddressTextView;

//地址选择器
@property (nonatomic ,strong) AddressPickerView * pickerView;

@end

@implementation SDEditAddressController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pickerView];
    
    self.navigationItem.title = self.addressModel == nil ? @"新增地址" : @"修改地址";
    [self wr_setNavBarTitleColor:white_color];
    
    [self setupUI];
    

}

-(void)setupUI{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(KScaleH(8)+NAVIGATION_HEIGHT);
        make.left.right.offset(0);
        make.height.offset(KScaleH(330));
    }];
    
    //收货人标题
    UILabel *consigneeTagLabel = [UILabel labelWithTextColor:RGB(102, 102, 102) andTextFontSize:AdjustFont(15) andNumblerOfLines:1 andText:@"收货人:"];
    [bgView addSubview:consigneeTagLabel];
    [consigneeTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(KScaleW(16));
        make.width.offset(WIDTH_LAB);
    }];
    
    //收货人
    UITextField *consigneeTF = [[UITextField alloc] init];
    consigneeTF.clearButtonMode = UITextFieldViewModeAlways;
    consigneeTF.placeholder = @"姓名";
    consigneeTF.text = self.addressModel.recv_name;
    consigneeTF.font = [UIFont systemFontOfSize:AdjustFont(14)];
    consigneeTF.delegate = self;
    [consigneeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:consigneeTF];
    [consigneeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(consigneeTagLabel).offset(0);
        make.left.equalTo(consigneeTagLabel.mas_right).offset(KScaleW(16));
        make.right.offset(-KScaleW(8));
    }];
    self.consigneeTF = consigneeTF;
    
    
    //分割线
    UIView *lineViewOne = [[UIView alloc] init];
    lineViewOne.backgroundColor = RGB(238, 238, 238);
    [bgView addSubview:lineViewOne];
    [lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(consigneeTagLabel.mas_bottom).offset(KScaleH(16));
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    
    //联系电话标题
    UILabel *phoneTagLabel = [UILabel labelWithTextColor:RGB(102, 102, 102) andTextFontSize:AdjustFont(15) andNumblerOfLines:1 andText:@"联系电话:"];
    [bgView addSubview:phoneTagLabel];
    [phoneTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineViewOne.mas_bottom).offset(KScaleH(16));
        make.left.offset(KScaleW(16));
        make.width.offset(WIDTH_LAB);
    }];
    
    //联系电话
    UITextField *phoneNumTF = [[UITextField alloc] init];
    phoneNumTF.clearButtonMode = UITextFieldViewModeAlways;
    phoneNumTF.placeholder = @"手机号";
    phoneNumTF.text = [NSString replaceStringWithOriginalStr:self.addressModel.recv_tel startLocation:3 length:4 withReplaceStr:@"*"];
    phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTF.font = [UIFont systemFontOfSize:AdjustFont(14)];
    phoneNumTF.delegate = self;
    [phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:phoneNumTF];
    [phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneTagLabel).offset(0);
        make.left.equalTo(phoneTagLabel.mas_right).offset(KScaleW(16));
        make.right.offset(-KScaleW(8));
    }];
    self.phoneNumTF = phoneNumTF;
    
    //分割线
    UIView *lineViewTwo = [[UIView alloc] init];
    lineViewTwo.backgroundColor = RGB(238, 238, 238);
    [bgView addSubview:lineViewTwo];
    [lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTagLabel.mas_bottom).offset(KScaleH(16));
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    
    //所在地区标题
    UILabel *areaTagLabel = [UILabel labelWithTextColor:RGB(102, 102, 102) andTextFontSize:AdjustFont(15) andNumblerOfLines:1 andText:@"所在地区:"];
    [bgView addSubview:areaTagLabel];
    [areaTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineViewTwo.mas_bottom).offset(KScaleH(16));
        make.left.offset(KScaleW(16));
        make.width.offset(WIDTH_LAB);
    }];
    
    //箭头图片
    UIImageView *arrowImgView = [[UIImageView alloc] init];
    arrowImgView.image = [UIImage imageNamed:@"addressIcons.bundle/more_arrow"];
    [bgView addSubview:arrowImgView];
    [arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(areaTagLabel).offset(0);
        make.right.offset(-KScaleW(16));
        make.width.offset(7.5);
    }];
    
    //所在地区
    UILabel *areaLabel = [UILabel labelWithTextColor:KRGB_36 andTextFontSize:AdjustFont(15) andNumblerOfLines:1 andText:self.addressModel ==nil? @"北京市":_addressModel.address_area];
    areaLabel.userInteractionEnabled = YES;
    [bgView addSubview:areaLabel];
    [areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(areaTagLabel).offset(0);
        make.left.equalTo(areaTagLabel.mas_right).offset(KScaleW(16));
        make.right.equalTo(arrowImgView.mas_left).offset(-KScaleW(16));
    }];
    self.areaLabel = areaLabel;
    
    //分割线
    UIView *lineViewThree = [[UIView alloc] init];
    lineViewThree.backgroundColor = RGB(238, 238, 238);
    [bgView addSubview:lineViewThree];
    [lineViewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaLabel.mas_bottom).offset(KScaleH(16));
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    
    //详细地址
    UITextView *detailAddressTextView = [[UITextView alloc] init];
    detailAddressTextView.placeholder = @"详细地址";
    detailAddressTextView.text = _addressModel.address_detail;
    detailAddressTextView.delegate = self;
    detailAddressTextView.font = [UIFont systemFontOfSize:AdjustFont(14)];
    [bgView addSubview:detailAddressTextView];
    [detailAddressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineViewThree.mas_bottom).offset(KScaleH(16));
        make.left.offset(KScaleW(16));
        make.right.offset(-KScaleW(16));
        make.height.offset(KScaleH(100));
    }];
    self.detailAddressTextView = detailAddressTextView;
    

    
    //所在地区点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecogizer)];
    [areaLabel addGestureRecognizer:tap];
    
    //保存地址按钮
    UIButton *saveAddressBtn = [[UIButton alloc] init];
    [saveAddressBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveAddressBtn.titleLabel.font = [UIFont systemFontOfSize:AdjustFont(14)];
    saveAddressBtn.backgroundColor = KThemeRed;
    saveAddressBtn.layer.cornerRadius = 4;
    saveAddressBtn.layer.masksToBounds = YES;
    [saveAddressBtn addTarget:self action:@selector(saveAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [saveAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [bgView addSubview:saveAddressBtn];
    [saveAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(detailAddressTextView.mas_bottom).offset(KScaleH(16));
        make.left.offset(KScaleW(16));
        make.right.offset(-KScaleW(16));
        make.height.offset(KScaleH(40));

    }];
    
    
   
}

#pragma mark - 保存按钮点击方法
-(void)saveAddressBtnClick{
    
    [self.view endEditing:YES];
    
    
    if ([_consigneeTF.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入收货人" duration:1 position:CSToastPositionTop];
        return;
    } else if([self.phoneNumTF.text isEqualToString:@""]){
        [self.view makeToast:@"请输入手机号" duration:1 position:CSToastPositionTop];
        return;
    }else if([self.areaLabel.text isEqualToString:@"北京市"]){
        [self.view makeToast:@"请选择地区" duration:1 position:CSToastPositionTop];
        return;
    }else if([self.detailAddressTextView.text isEqualToString:@""]){
        [self.view makeToast:@"请输入详细地址" duration:1 position:CSToastPositionTop];
        return;
    }else{
        
         [self loadEditAddAddressData];
    }
    
    
}

#pragma mark - 监听TextField输入
-(void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == self.phoneNumTF) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
}
#pragma mark - 所在地区点击手势
-(void)tapGestureRecogizer{
    [self.view endEditing:YES];
    NSLog(@"所在地区点击手势");
    
     [self.pickerView show];
    
}

#pragma mark - 点击屏幕空白处 收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    //隐藏地址选择器
    [self.pickerView hide];
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    
    //隐藏地址选择器
    [self.pickerView hide];
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    self.areaLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
 
    [self.pickerView hide];
}
#pragma mark - 懒加载
- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.titleColor = [UIColor darkGrayColor];
        [_pickerView setTitleHeight:50 pickerViewHeight:200];
        
        // 关闭默认支持打开上次的结果
        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //隐藏地址选择器
    [self.pickerView hide];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //隐藏地址选择器
    [self.pickerView hide];
    return YES;
    
}

#pragma mark - 网络请求 新增-0  修改-1 删除-2
-(void)loadEditAddAddressData{
    
   
    
    
}


@end
