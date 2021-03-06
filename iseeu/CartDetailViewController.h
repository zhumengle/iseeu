//
//  CartDetailViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

#import "CartDetailTableViewCell.h"

#import "CartActionDetail.h"

#import "ViewController.h"

#import "FootView.h"

#import "UserInfoViewController.h"

#import "ValidataLogin.h"

#import "MarketViewController.h"

@interface CartDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DeleteReloadCartDetail,UIAlertViewDelegate,FootPushViewDelegate>

@property(strong,nonatomic)UITableView *_tableView;

@property(strong,nonatomic)NSMutableArray *_tableData;

@property(nonatomic)int _deleteId;

@property(strong,nonatomic)UILabel *_cartNumber;

@property(strong,nonatomic)UILabel *_sumPriceValue;

@property(strong,nonatomic)NSString *_uid;

@end
