//
//  STKGestureFingerLoginViewController.m
//  Tronker
//
//  Created by soffice-Jimmy on 2017/3/4.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "STKGestureFingerLoginViewController.h"
#import "SFAuthenticationTool.h"
#import "SFUIBuilderHeader.h"

#define kLogoImageWidth 230
#define kLogoImageHeight 64
#define kFingerPrintWidth 55
#define kFingerPrintHeight 72
#define kLockViewSize 360
#define kButtonHeight 40

@interface STKGestureFingerLoginViewController ()

@property (strong, nonatomic) UIImageView   *mLogoImageView;            // Logo
@property (strong, nonatomic) UILabel       *mAccountLabel;             // 账号
@property (strong, nonatomic) UIButton      *mFingerPrintButton;        // 指纹容器按钮
@property (strong, nonatomic) UIButton      *mFingerPrintImageButton;   // 指纹图片按钮
@property (strong, nonatomic) UIButton      *mFingerPrintTextButton;    // 指纹提示点击按钮
@property (strong, nonatomic) UIButton      *mChangeLoginButton;        // 切换登录方式

@property (assign, nonatomic) BOOL          mFingerPrintOnOff;          // 指纹是否开启

@end

@implementation STKGestureFingerLoginViewController

#pragma mark - 生命周期

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mFingerPrintOnOff = [[SFAuthenticationTool sharedInstance] authenticationIsOpenithIndentity:self.account];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self fingerPrintButtonClick:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self loadComponent];
    
}

- (void)dealloc {
    DLog(@"%@ dealloc ",self);
}

#pragma mark - 加载组件

- (void)loadComponent
{
    WEAKSELF
    // Logo
    self.mLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_new"]];
    self.mLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.mLogoImageView];
    [self.mLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(64);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.equalTo(@(kLogoImageWidth));
        make.height.equalTo(@(kLogoImageHeight));
    }];
    
    // 账号
    self.mAccountLabel = [[UILabel alloc] init];
    self.mAccountLabel.textColor = color(666666);
    self.mAccountLabel.textAlignment = NSTextAlignmentCenter;
    self.mAccountLabel.font = Fnt(@16);
    self.mAccountLabel.text = [NSString stringWithFormat:@"账号:%@",self.account];
    [self.view addSubview:self.mAccountLabel];
    [self.mAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mLogoImageView.mas_bottom).with.offset(24);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(16);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-16);
        make.height.equalTo(@(22));
    }];
    
    // 指纹容器
    self.mFingerPrintButton = [[UIButton alloc]init];
    [self.mFingerPrintButton addTarget:self action:@selector(fingerPrintButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mFingerPrintButton];
    [self.mFingerPrintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(16);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-16);
        make.top.equalTo(weakSelf.mAccountLabel.mas_bottom).with.offset(80);
        make.height.equalTo(@(120));
    }];
    
    // 指纹图标
    self.mFingerPrintImageButton = [[UIButton alloc] init];
    [self.mFingerPrintImageButton setImage:[UIImage imageNamed:@"finger_print"] forState:UIControlStateNormal];
    self.mFingerPrintImageButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.mFingerPrintImageButton addTarget:self action:@selector(fingerPrintButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mFingerPrintButton addSubview:self.mFingerPrintImageButton];
    [self.mFingerPrintImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mFingerPrintButton.mas_top);
        make.centerX.equalTo(weakSelf.mFingerPrintButton.mas_centerX);
        make.width.equalTo(@(kFingerPrintWidth));
        make.height.equalTo(@(kFingerPrintHeight));
    }];
    
    // 指纹提示
    self.mFingerPrintTextButton = [[UIButton alloc] init];
    [self.mFingerPrintTextButton setTitleColor:color(329BFF) forState:UIControlStateNormal];
    [self.mFingerPrintTextButton setTitleColor:color(C1E1FF) forState:UIControlStateHighlighted];
    self.mFingerPrintTextButton.titleLabel.font = Fnt(@14);
    [self.mFingerPrintTextButton setTitle:@"点击进行指纹解锁" forState:UIControlStateNormal];
    [self.mFingerPrintTextButton addTarget:self action:@selector(fingerPrintButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mFingerPrintButton addSubview:self.mFingerPrintTextButton];
    [self.mFingerPrintTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mFingerPrintImageButton.mas_bottom).with.offset(24);
        make.left.equalTo(weakSelf.mFingerPrintButton.mas_left).with.offset(16);
        make.right.equalTo(weakSelf.mFingerPrintButton.mas_right).with.offset(-16);
        make.height.equalTo(@(22));
    }];
    
    // 登录方式按钮
    self.mChangeLoginButton = [[UIButton alloc]init];
    [self.mChangeLoginButton setTitleColor:color(329BFF) forState:UIControlStateNormal];
    [self.mChangeLoginButton setTitleColor:color(C1E1FF) forState:UIControlStateHighlighted];
    self.mChangeLoginButton.titleLabel.font = Fnt(@16);
    [self.mChangeLoginButton setTitle:@"切换登录方式" forState:UIControlStateNormal];
    [self.mChangeLoginButton addTarget:self action:@selector(changeLoginToPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mChangeLoginButton];
    [self.mChangeLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(16*5);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-16*5);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(-16);
        make.height.equalTo(@(kButtonHeight));
    }];
}

//密码登录
- (void)changeLoginToPwd {
    if (self.toLoginBlock) {
        self.toLoginBlock();
    }
}

#pragma mark - 自定义响应事件

// 指纹点击事件
- (void)fingerPrintButtonClick:(UIButton *)button
{
    self.mFingerPrintButton.userInteractionEnabled = NO;
    WEAKSELF
    [[SFAuthenticationTool sharedInstance] evaluateAuthenticateWithFallbackTitle:@"验证登录密码" validateChange:YES result:^(BOOL success, NSString *alertTitle) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.mFingerPrintButton.userInteractionEnabled = YES;
        });
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                DLog(@"验证成功去首页");
                if (weakSelf.toHomeBlock) {
                    weakSelf.toHomeBlock();
                }
            });
        }
        else
        {
            DLog(@"验证失败：%@",alertTitle);
            if (alertTitle) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:nil  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction     *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertController addAction:okAction];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
        }
    } fallBack:^(NSString *message){
        
        if (message) { //有消息提示,同时去登录
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction     *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:okAction];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }
        weakSelf.mFingerPrintButton.userInteractionEnabled = YES;
        
        DLog(@"去登录了: %@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.toLoginBlock) {
                weakSelf.toLoginBlock();
            }
        });
    } cancel:^(BOOL authFailed) {
        
        weakSelf.mFingerPrintButton.userInteractionEnabled = YES;
        
        // 取消
        if (authFailed) { //告知不匹配指纹
            dispatch_async(dispatch_get_main_queue(), ^{
                DLog(@"指纹不匹配");
                if (weakSelf.showTooatBlock) {
                    weakSelf.showTooatBlock(@"指纹不匹配");
                }
            });
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.mFingerPrintButton.userInteractionEnabled = YES;
    });
}

@end
