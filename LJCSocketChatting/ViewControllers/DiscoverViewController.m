//
//  MarketViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/26.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Users.h"


@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSString *cellId;
}
@property (nonatomic,weak)UITableView *mainTableView;
@property (nonatomic,strong)NSArray *usersArr;
@end


@implementation DiscoverViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    cellId = @"cellId";
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        [self.topView removeAllSubviews];
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-40, 25)];
        searchBar.delegate = self;
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        searchBar.backgroundImage = [UIImage new];
        searchBar.barTintColor = UIColorRGBA(40, 102, 194, 1);
        searchBar.placeholder = @"搜索好友";
        searchBar.showsCancelButton = YES;
        UITextField *searchField = [searchBar valueForKey:@"searchField"];
        if (searchField) {
            searchField.layer.masksToBounds = YES;
            searchField.layer.cornerRadius = 14;
            [searchField.layer setBorderWidth:0.1];
            [searchField.layer setBorderColor:UIColorRGBA(40, 102, 194, 1).CGColor];
            searchField.textColor = WHITE_COLOR;
        }
        
        UIButton *cancelButton = [searchBar valueForKey:@"cancelButton"];
        if (cancelButton) {
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [cancelButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
            cancelButton.titleLabel.font = Font(13);
        }
        //[self.topView addSubview:searchField];
        [self.topView addSubview:searchBar];
        
    }];
    [self.searchView addGestureRecognizer:tapGesture];
    
    Users *user1 = [Users new];
    user1.usersNikename = @"任志强";
    user1.userinfos = @[@"闷声发大财"];
    
    Users *user2 = [Users new];
    user2.usersNikename = @"潘石屹";
    user2.userinfos = @[@"亦可赛艇"];
    
    Users *user3 = [Users new];
    user3.usersNikename = @"刘德华";
    user3.userinfos = @[@"撒打算打算打算打算"];
    
    _usersArr = @[user1,user2,user3];
    [self.view addSubview:self.mainTableView];
    //[self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    @weakify(self)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        UIEdgeInsets inset = UIEdgeInsetsMake(40,0,50,0);
        make.edges.equalTo(self.view).insets(inset);
        //make.edges.equalTo(self.view);
    }];
    //加载完重新刷新tableView
    //[self.mainTableView reloadData];
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44.f;
        tableView.tableFooterView = [UIView new];
        
        return _mainTableView = tableView;
    }
    return _mainTableView;
}

#pragma mark UITableviewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    Users *user = _usersArr[indexPath.row];
    cell.imageView.image = IMAGE_No_Cache(@"mood_himonoonna_icon_no");
    cell.textLabel.font = Font(13);
    cell.textLabel.text = user.usersNikename;
    cell.detailTextLabel.textColor = GRAY_COLOR;
    cell.detailTextLabel.font = Font(11);
    cell.detailTextLabel.text = user.userinfos[0];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-20, 30)];
    label.text = @"推荐关注";
    label.font = Font(13);
    label.textColor = GRAY_COLOR;
    
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark UITableViewDataSource

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _usersArr.count;
}

#pragma mark UISearchBarDelegate
//将要开始编辑时的回调，返回为NO，则不能编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    UIButton *cancelButton = [searchBar valueForKey:@"cancelButton"];
    if (cancelButton) {
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        cancelButton.titleLabel.font = Font(13);
    }
    return YES;
}

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

//将要结束编辑时的回调
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    
//    return YES;
//}


//已经结束编辑的回调
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//
//}


//编辑文字改变的回调
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//}

//编辑文字改变前的回调，返回NO则不能加入新的编辑文字
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    return YES;
//}

//搜索按钮点击的回调
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //调搜索接口，返回数据并刷新tableview
    
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    [searchBar endEditing:YES];
}

//搜索结果按钮点击的回调
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScop{
    
}



@end
