//
//  UserInfoViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "UserInfoViewController.h"

@implementation UserInfoViewController

@synthesize _aboutTableView;

@synthesize _tableArray;

@synthesize _hud;

@synthesize _uid;

@synthesize _userPhoto;

@synthesize _userNameLabel;

@synthesize _scoreLabel;

@synthesize _scoreUsedLabel;

@synthesize _noticeLabel;

@synthesize _touImage;

@synthesize _userInfo;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"个人中心";
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    ValidataLogin *validataLogin = [[ValidataLogin alloc] init];
    
    NSDictionary *validata = [validataLogin validataUserInfo];

    NSString *username = [validata objectForKey:@"username"];
    
    NSString *password = [validata objectForKey:@"password"];
    
    _uid = [validata objectForKey:@"uid"] ;
    
    if (![username isEqualToString:@""]&&![password isEqualToString:@""]) {
        
        if ([self.view subviews].count>0) {
            for (UIView *view in [self.view subviews]) {
                [view removeFromSuperview];
            }
        }
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height-49.0f)];
        
        [scrollView setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview:scrollView];
        
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 120.0)];
        
        [topView setImage:[UIImage imageNamed:@"personal_balack"]];
        
        [scrollView addSubview:topView];
        
        _userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 100.0, 100.0)];
        
        [_userPhoto setImage:[UIImage imageNamed:@"personal"]];
        
        _userPhoto.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhotoOptions)];
        
        [_userPhoto addGestureRecognizer:singleTap1];
        
        [scrollView addSubview:_userPhoto];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userPhoto.frame.origin.x+_userPhoto.frame.size.width+10.0, 10.0, self.view.frame.size.width-_userPhoto.frame.origin.x-_userPhoto.frame.size.width, 30.0)];
        
        [_userNameLabel setTextColor:[UIColor whiteColor]];
        
        [scrollView addSubview:_userNameLabel];
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x, _userNameLabel.frame.origin.y+_userNameLabel.frame.size.height, 60.0, 30.0)];
        
        [_scoreLabel setTextColor:[UIColor whiteColor]];
        
        [scrollView addSubview:_scoreLabel];
        
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+2, _scoreLabel.frame.origin.y+2, self.view.frame.size.width-_scoreLabel.frame.origin.x-_scoreLabel.frame.size.width-5.0, 30.0)];
        
        [_noticeLabel setText:@"小提示:签到可获得一定的积分哦！"];
        
        _noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _noticeLabel.numberOfLines = 0;
        
        [_noticeLabel setFont:[UIFont systemFontOfSize:11.0]];
        
        [_noticeLabel setTextColor:[UIColor redColor]];
        
        [scrollView addSubview:_noticeLabel];
        
        _scoreUsedLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x, _scoreLabel.frame.origin.y+_scoreLabel.frame.size.height, self.view.frame.size.width-_userPhoto.frame.origin.x-_userPhoto.frame.size.width, 30.0)];
        
        [_scoreUsedLabel setTextColor:[UIColor whiteColor]];
        
        [scrollView addSubview:_scoreUsedLabel];
        
        CGFloat width = (self.view.frame.size.width-20.0)/3;
        
        UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [orderButton setFrame:CGRectMake(10.0, topView.frame.origin.y+topView.frame.size.height+5.0, width, 70.0)];
        
        [orderButton setBackgroundImage:[UIImage imageNamed:@"ordermanager"] forState:UIControlStateNormal];
        
        [orderButton addTarget:self action:@selector(pushOrderView) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:orderButton];
        
        UIButton *checkinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [checkinButton setFrame:CGRectMake(orderButton.frame.origin.x+orderButton.frame.size.width, orderButton.frame.origin.y, width, 70.0)];
        
        [checkinButton setBackgroundImage:[UIImage imageNamed:@"checkin"] forState:UIControlStateNormal];
        
        [checkinButton addTarget:self action:@selector(checkinAction) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:checkinButton];
        
        UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [scoreButton setFrame:CGRectMake(checkinButton.frame.origin.x+checkinButton.frame.size.width, orderButton.frame.origin.y, width, 70.0)];
        
        [scoreButton setBackgroundImage:[UIImage imageNamed:@"personal_score"] forState:UIControlStateNormal];
        
        [scoreButton addTarget:self action:@selector(scoreManage) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:scoreButton];
        
        UIImageView *shoppingView = [[UIImageView alloc] initWithFrame:CGRectMake(orderButton.frame.origin.x, orderButton.frame.size.height+orderButton.frame.origin.y+5.0, self.view.frame.size.width-20.0, 50.0)];
        
        [shoppingView setImage:[UIImage imageNamed:@"baseshoppijng"]];
        
        [scrollView addSubview:shoppingView];
        
        _tableArray = [NSArray arrayWithObjects:@"基本资料",@"修改密码",@"修改送货地址",@"意见反馈", nil];
        
        _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(shoppingView.frame.origin.x, shoppingView.frame.origin.y+shoppingView.frame.size.height+10.0, shoppingView.frame.size.width, 175.0)];
        
        _aboutTableView.scrollEnabled = NO;
        
        _aboutTableView.delegate = self;
        
        _aboutTableView.dataSource = self;
        
        [scrollView addSubview:_aboutTableView];
        
        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _aboutTableView.frame.origin.y+_aboutTableView.frame.size.height)];
        
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:_hud];
        
        _hud.delegate = self;
        
        [_hud setLabelText:@"加载中..."];
        
        [_hud show:YES];
        
        [self loadUserInfo];
        
    }else{
        
        [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
        
        [imageView setImage:[UIImage imageNamed:@"personal_infobalack"]];
        
        [self.view addSubview:imageView];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [loginButton setFrame:CGRectMake((self.view.frame.size.width-100)/2, 150.0, 100.0, 30.0)];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"nolongin_submmit"] forState:UIControlStateNormal];
        
        [loginButton addTarget:self action:@selector(pushLoginView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginButton];
        
        UIImageView *newShare = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, imageView.frame.origin.y+imageView.frame.size.height+10.0, self.view.frame.size.width-20.0, 45.0)];
        
        [newShare setImage:[UIImage imageNamed:@"new_share"]];
        
        [self.view addSubview:newShare];
        
        _tableArray = [NSArray arrayWithObjects:@"关于Iseeu",@"更多", nil];
        
        _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(newShare.frame.origin.x, newShare.frame.origin.y+newShare.frame.size.height+10.0, newShare.frame.size.width, 90.0)];
        
        _aboutTableView.scrollEnabled = NO;
        
        _aboutTableView.delegate = self;
        
        _aboutTableView.dataSource = self;
        
        [self.view addSubview:_aboutTableView];
        
    }
    
    FootView *footView = [[FootView alloc] initWithFrame:CGRectMake(0.0, [[UIScreen mainScreen] bounds].size.height-49.0-64.0f, self.view.frame.size.width, 49.0)];
    
    [footView set_activeView:5];
    
    [footView setViewDelegate:self];
    
    [footView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:footView];
    
}

-(void)viewDidLoad{
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
}

-(void)loadUserInfo{
    
    NSString *userUrl = [NSString stringWithFormat:@"%@/index.php/user/index",SERVER_URL];
    
    NSDictionary *params = @{@"uid":_uid};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:userUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *data = [dictionary objectForKey:@"xin"];
        
        _userInfo = [[UserInfo alloc] getUserInfo:data];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[data objectForKey:@"tou"]]]];
        
        _touImage = [NSString stringWithFormat:@"%@/%@",SERVER_URL,_userInfo.tou];
        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"]];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (image != nil) {
            
            _userPhoto.image = image;
            
            [_userPhoto.layer setCornerRadius:CGRectGetHeight([_userPhoto bounds]) / 2];  //修改半径，实现头像的圆形化
            
            _userPhoto.layer.masksToBounds = YES;
            
        }
        
        [_userNameLabel setText:[NSString stringWithFormat:@"%@",_userInfo.username]];
        
        NSString *scoreText = [NSString stringWithFormat:@"积分：%@",_userInfo.sum_jifen];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        
        CGSize textSize = [scoreText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        [_scoreLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x, _scoreLabel.frame.origin.y, textSize.width, _scoreLabel.frame.size.height)];
        
        [_scoreLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_scoreLabel setText:scoreText];
        
        [_noticeLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+2, _scoreLabel.frame.origin.y+2, self.view.frame.size.width-_scoreLabel.frame.origin.x-_scoreLabel.frame.size.width-5.0, 30.0)];
        
        [_scoreUsedLabel setText:[NSString stringWithFormat:@"已使用积分：%@",_userInfo.yi_jifen]];
        
        [_hud hide:YES];
        
        NSLog(@"%@",dictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];

}

-(void)showPhotoOptions{

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选取", nil];
    
    sheet.delegate = self;
    
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSLog(@"%li",(long)buttonIndex);
    
    if (buttonIndex == 0) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
    }else{
        
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.allowsEditing=YES;
        
        picker.delegate=self;
        
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"载入图片库");
        }];
        
        [self.view addSubview:picker.view];
    
    }
    
}

//保存获取的照片
-(void)saveImage:(UIImage *)image{
    
    NSLog(@"baocun");
    
    NSString *touUrl = [NSString stringWithFormat:@"%@/index.php/user/tou",SERVER_URL];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *image64 = [data base64String];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png",image64];
    
    NSDictionary *params = @{@"uid":_uid,@"tou":fileName};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:touUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"tou" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableString *responseString = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [self showAlert:@"上传成功！"];
        
        NSString *userUrl = [NSString stringWithFormat:@"%@/index.php/user/index",SERVER_URL];
        
        NSDictionary *params = @{@"uid":_uid};
        
        [manager POST:userUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSDictionary *data = [dictionary objectForKey:@"xin"];
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[data objectForKey:@"tou"]]]];
            
            _touImage = [NSString stringWithFormat:@"%@/%@",SERVER_URL,_userInfo.tou];
            
            UIImage *image = [UIImage imageWithData:imageData];
            
            if (image != nil) {
                
                _userPhoto.image = image;
                
                [_userPhoto.layer setCornerRadius:CGRectGetHeight([_userPhoto bounds]) / 2];  //修改半径，实现头像的圆形化
                
                _userPhoto.layer.masksToBounds = YES;
                
            }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self showAlert:@"上传失败！"];
            
            NSLog(@"error");
            
        }];
        
        
        NSLog(@"success%@",responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self showAlert:@"上传失败！"];
        
        NSLog(@"error");
        
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"完成图片库");
    }];
//    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSLog(@"%f,%f",image.size.height,image.size.width);
    
//    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(100, 100)];
    
    UIImage *smallImage = [self scaleFromImage:image toSize:CGSizeMake(100, 100)];
    
    NSLog(@"%f,%f",smallImage.size.height,smallImage.size.width);
    
    //UIImage *image1=[info objectForKey:UIImagePickerControllerOriginalImage];//获取未编辑的照片
    
    [self performSelector:@selector(saveImage:)withObject:smallImage afterDelay:0.5];//延迟0.5秒获取照片
    
}

- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消图片库");
    }];
    
}

-(void)goBack{

    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)pushLoginView{

    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_tableArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdetify = @"aboutCell";
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%li",(long)indexPath.row);
    
    if (indexPath.row == 0) {

        if ([[_tableArray objectAtIndex:indexPath.row] isEqualToString:@"关于Iseeu"]) {
            AboutAppViewController *aboutAppViewController = [[AboutAppViewController alloc] init];
            [self.navigationController pushViewController:aboutAppViewController animated:YES];
        }else{
            UserMaterialViewController *userMaterialViewController = [[UserMaterialViewController alloc] init];
            
            [userMaterialViewController set_uid:_uid];
            
            [self.navigationController pushViewController:userMaterialViewController animated:YES];
        }
        
    }else if(indexPath.row == 1){
        if ([[_tableArray objectAtIndex:indexPath.row] isEqualToString:@"更多"]) {
            MoreViewController *moreViewController = [[MoreViewController alloc] init];
            [self.navigationController pushViewController:moreViewController animated:YES];
        }else{
            ModifyPasswordViewController *modifyPasswordViewController = [[ModifyPasswordViewController alloc] init];
            
            [modifyPasswordViewController set_uid:_uid];
            
            [self.navigationController pushViewController:modifyPasswordViewController animated:YES];
        }
        
    }else if (indexPath.row ==2){
    
        ModifyAddressViewController *modifyAddressViewController = [[ModifyAddressViewController alloc] init];
        
        [modifyAddressViewController set_uid:_uid];
        
        [self.navigationController pushViewController:modifyAddressViewController animated:YES];
        
    }else if (indexPath.row ==3){
        
        FeedBackViewController *feedBackViewController = [[FeedBackViewController alloc] init];
        
        [feedBackViewController set_uid:_uid];
        
        [self.navigationController pushViewController:feedBackViewController animated:YES];
        
    }
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud{

    [_hud removeFromSuperview];
    
    _hud = nil;
    
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}


-(void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

-(void)pushOrderView{
    
    OrderManageViewController *orderManageViewController = [[OrderManageViewController alloc] init];
    
    [orderManageViewController set_uid:_uid];
    
    [self.navigationController pushViewController:orderManageViewController animated:YES];

}

-(void)checkinAction{
    
    NSString *checkinUrl = [NSString stringWithFormat:@"%@/index.php/user/qiandaoadd",SERVER_URL];
    
    NSDictionary *params = @{@"uid":_uid};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:checkinUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"a"]];
        if ([data isEqualToString:@"1"]) {
            [self showAlert:@"今天已签到过！"];
        }else if([data isEqualToString:@"2"]) {
            
            NSString *userUrl = [NSString stringWithFormat:@"%@/index.php/user/index",SERVER_URL];
            
            NSDictionary *params = @{@"uid":_uid};
            
            [manager POST:userUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                NSDictionary *data = [dictionary objectForKey:@"xin"];
                
                _userInfo = [[UserInfo alloc] getUserInfo:data];
                
                NSString *scoreText = [NSString stringWithFormat:@"积分：%@",_userInfo.sum_jifen];
                
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
                
                CGSize textSize = [scoreText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                
                [_scoreLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x, _scoreLabel.frame.origin.y, textSize.width, _scoreLabel.frame.size.height)];
                
                [_scoreLabel setFont:[UIFont systemFontOfSize:15]];
                
                [_scoreLabel setText:scoreText];
                
                [_noticeLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+2, _scoreLabel.frame.origin.y+2, self.view.frame.size.width-_scoreLabel.frame.origin.x-_scoreLabel.frame.size.width-5.0, 30.0)];
                
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error");
            }];
            
            [self showAlert:@"签到成功！"];
        }
        NSLog(@"%@",dictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];

}

-(void)scoreManage{
    
    ScoreManageViewController *scoreManageViewController = [[ScoreManageViewController alloc] init];
    
    [scoreManageViewController set_uid:_uid];
    
    [scoreManageViewController set_userInfo:_userInfo];
    
    [self.navigationController pushViewController:scoreManageViewController animated:YES];

}

-(void)pushViewController:(int)type{
    
    if (type==0) {
        
        BOOL isHave = NO;
        
        ViewController *viewController = [[ViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:viewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:viewController animated:NO];
        }
        
    }
    
    if (type==1) {
        
        BOOL isHave = NO;
        
        EyeColorViewController *eyeColorViewController = [[EyeColorViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:eyeColorViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:eyeColorViewController animated:NO];
        }
        
    }
    
    if (type == 2) {
        
        BOOL isHave = NO;
        
        MarketViewController *marketViewController = [[MarketViewController alloc] init];
        
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:marketViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:marketViewController animated:NO];
        }
        
    }
    
    
    if (type == 3) {
        
        BOOL isHave = NO;
        
        CartDetailViewController *cartDetailViewController = [[CartDetailViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:cartDetailViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:cartDetailViewController animated:NO];
        }
        
    }

    
}

@end
