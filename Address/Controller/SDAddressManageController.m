







//地址管理
#import "SDAddressManageController.h"
#import "SDAddressManageCell.h"
#import "SDEditAddressController.h"     //编辑/新增地址


@interface SDAddressManageController ()<UITableViewDelegate,
                                        UITableViewDataSource,
                                        SDAddressManageCellDelegate
                                        >

@property (nonatomic, strong) UITableView *tableView;
/** 新增地址 */
@property (nonatomic, strong) UIButton *newAddressBtn;

//保存地址信息
//@property (nonatomic, strong) NSMutableArray *addressArray;


@end
//重用标识
static NSString *cellId = @"cellId";

@implementation SDAddressManageController


- (void)viewDidLoad {
    [super viewDidLoad];
//    _addressArray = [NSMutableArray array];

    NSString *title = _navigationTitle == nil? @"地址管理":_navigationTitle;
    self.navigationItem.title = title;
    [self wr_setNavBarTitleColor:white_color];
    
    [self.view addSubview:self.newAddressBtn];
    [self.view addSubview:self.tableView];
    

}

-(UIButton *)newAddressBtn{
    if (_newAddressBtn == nil) {
        _newAddressBtn = [[UIButton alloc] init];
        _newAddressBtn.frame = CGRectMake(0, SCREEN_HEIGHT-SAFE_BOTTOM_MARGIN_V-KScaleH(40), SCREEN_WIDTH, KScaleH(40));
        [_newAddressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
        _newAddressBtn.titleLabel.font = [UIFont systemFontOfSize:AdjustFont(14)];
        _newAddressBtn.backgroundColor = KThemeRed;
        [_newAddressBtn addTarget:self action:@selector(newAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_newAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_newAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    return _newAddressBtn;
}

#pragma mark - 新增地址点击事件
-(void)newAddressButtonClick{
    
    NSLog(@"新增地址");
    
    SDEditAddressController *editAddressVC = [[SDEditAddressController alloc] init];
    [self.navigationController pushViewController:editAddressVC animated:YES];
    
   
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SDAddressManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.delegate = self;
//    cell.addressModel = _addressArray[indexPath.row];
    
    return cell;
    
}
#pragma mark - cell中删除按钮点击代理方法
-(void)addressManageCellButtonClick:(SDAddressManageCell *)cell deleteButton:(UIButton *)button{
   
    NSLog(@"222222");
}
#pragma mark - cell中默认按钮点击代理方法
-(void)addressManageCellButtonClick:(SDAddressManageCell *)cell defaultButton:(UIButton *)button{
    
    //网络请求 设置默认地址
    [self loadEditAddAddressDataWithType:@"1" addressModel:cell.addressModel isdefault:button.selected];
    
    //将数据传给结算控制器
    if ([self.delegate respondsToSelector:@selector(addressManageControllerDefaultButtonClick:addressModel:)]) {
        [self.delegate addressManageControllerDefaultButtonClick:self addressModel:cell.addressModel];
    }
    
    
}

#pragma mark - 点击cell 选择地址
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    MTAddressModel *addressModel =  _addressArray[indexPath.row];
    
//    //将数据传给结算控制器
//    if ([self.delegate respondsToSelector:@selector(addressManageControllerDefaultButtonClick:addressModel:)]) {
//        [self.delegate addressManageControllerDefaultButtonClick:self addressModel:addressModel];
//    }
    
}


#pragma mark - 加载地址数据
-(void)loadAddressData{
    
   
    
}

#pragma mark - 网络请求 修改默认地址-1 删除地址-2
-(void)loadEditAddAddressDataWithType:(NSString *)type addressModel:(MTAddressModel *)addressModel isdefault:(BOOL)isdefault{
    
   
    
}



-(UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.newAddressBtn.y) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
        _tableView.estimatedRowHeight = KScaleH(140);
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[SDAddressManageCell class] forCellReuseIdentifier:cellId];
        
        _tableView.contentInset = UIEdgeInsetsMake(NAVIGATION_HEIGHT, 0, 0, 0);
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self loadAddressData];
        }];
    }
    return _tableView;
}
@end
