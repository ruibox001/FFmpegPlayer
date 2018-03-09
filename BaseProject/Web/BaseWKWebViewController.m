//
//  BaseWKWebViewController.m
//  Tronker
//
//  Created by soffice-Jimmy on 2017/4/12.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "BaseWKWebViewController.h"
#import <WebKit/WebKit.h>

#define startBg [UIColor whiteColor].colorAlpha(0.9)
#define endBg [UIColor whiteColor].colorAlpha(0.9)

#define kprogressKey @"estimatedProgress"
#define ktitle @"title"

@interface BaseWKWebViewController() <WKNavigationDelegate,WKUIDelegate>


@property (strong, nonatomic) WKWebView                 *wkwebView;
@property (strong, nonatomic) WKUserContentController   *uContentController;

//进度条
@property (strong, nonatomic) CAGradientLayer    *changeColorLayer;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) WKJsMethodControl *jsController;

@end

@implementation BaseWKWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor].colorAlpha(0.9);
    WEAKSELF
    if ([self isPush]) {
        [self addNavigationLeft:nil clickBlock:^(NSInteger index) {
            if ([weakSelf.wkwebView goBack]) {
                [weakSelf.wkwebView goBack];
            }
            else {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
    [self initWKWebView];
}

- (WKJsMethodControl *)jsController {
    if (!_jsController) {
        _jsController = [[WKJsMethodControl alloc] initWithUcontentController:self.uContentController delegate:nil];
    }
    return _jsController;
}

- (WKUserContentController *)uContentController {
    if (!_uContentController) {
        _uContentController = [[WKUserContentController alloc] init];
    }
    return _uContentController;
}

- (void)initWKWebView{
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = self.uContentController;
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // 测试嵌入JS
    //    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"var param = {'key':'value'}; if(window.webkit){window.alert('test alert'); window.webkit.messageHandlers.gotoLogin.postMessage(param)}" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    //    [_userContentController addUserScript:script];
    CGFloat topY = [self isPush]? naviHeight : 0;
    self.wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, topY, phoneWidth, phoneHeight-topY) configuration:configuration];
    //    self.wkwebView.scrollView.bounces = NO;
    self.wkwebView.scrollView.backgroundColor = startBg;
    self.wkwebView.UIDelegate = self;
    self.wkwebView.navigationDelegate = self;
    
    //适配iOS11
    _Pragma("clang diagnostic push") 
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {
        [self.wkwebView.scrollView performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _Pragma("clang diagnostic pop")
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        self.wkwebView.allowsLinkPreview = YES; //允许预览链接
    }
    
    [self.view addSubview:self.wkwebView];
    
    [self.wkwebView addObserver:self forKeyPath:kprogressKey options:NSKeyValueObservingOptionNew context:nil];//注册observer 拿到加载进度
    [self.wkwebView addObserver:self forKeyPath:ktitle options:NSKeyValueObservingOptionNew context:nil];//注册observer 拿到标题
    [self request];
}

- (WKJsMethodControl *)getJsController {
    return self.jsController;
}

- (void)setTitleString:(NSString *)titleString
{
    if ([self isPush]) {
        _titleString = titleString;
        [self addNavigationTitle:titleString tintColor:[UIColor whiteColor]];
    }
}

- (void)setUrlString:(NSString *)urlString
{
    // 带上登录Token在这里处理
    _urlString = urlString;
}

- (void)mydealloc
{
    [[self getJsController] removeAllMethods];
    [self.wkwebView removeObserver:self forKeyPath:kprogressKey];
    [self.wkwebView removeObserver:self forKeyPath:ktitle];
    [super mydealloc];
}

// 监听事件处理进度和网页标题
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:kprogressKey]){
        self.changeColorLayer.hidden = NO;
        CGFloat  progress = [change[@"new"] floatValue];
        CGFloat topY = [self isPush]? naviHeight : 0;
        self.changeColorLayer.frame = CGRectMake(0, topY, phoneWidth * progress,  4);
        if (progress == 1.0) {
            self.changeColorLayer.hidden =YES;
        }
    } else if ([keyPath isEqualToString:ktitle]){
        if (self.titleString == nil || self.titleString.length == 0) {
            NSString *title = [NSString stringWithFormat:@"%@", change[@"new"]];
            self.titleString = title;
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// 刷新
- (void)request
{
    NSURL* url = [NSURL URLWithString:self.urlString];//创建URL
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.f];
    [self.wkwebView loadRequest:request];//加载
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    DLog(@"Url = %@", webView.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//接收到服务器响应 后决定是否允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    DLog(@"接收到响应后 allow 跳转 Url = %@", self.wkwebView.URL.absoluteString);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//兼容alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    DLog(@"页面加载开始 url = %@", self.wkwebView.URL.absoluteString);
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    DLog(@"页面加载完成 url = %@", self.wkwebView.URL.absoluteString);
    [self.activityIndicator stopAnimating];
    self.wkwebView.scrollView.backgroundColor = endBg;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    DLog(@"页面加载失败 Url = %@", webView.URL.absoluteString);
    [self.activityIndicator stopAnimating];
    self.wkwebView.scrollView.backgroundColor = endBg;
}

#pragma mark - Getter

- (CAGradientLayer *)changeColorLayer {
    if (!_changeColorLayer) {
        _changeColorLayer = [CAGradientLayer layer];
        CGFloat topY = [self isPush]? naviHeight : 0;
        _changeColorLayer.frame = CGRectMake(0, topY, 0, 4);
        _changeColorLayer.startPoint = CGPointMake(0, 1);
        _changeColorLayer.endPoint   = CGPointMake(1, 1);
        _changeColorLayer.colors     = @[(__bridge id)color(10E010).CGColor,
                                         (__bridge id)color(10E010).CGColor];
        [self.view.layer addSublayer:_changeColorLayer];
    }
    return _changeColorLayer;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activityIndicator.center = CGPointMake(self.view.center.x, self.view.center.y - 30);
        [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

- (BOOL)isPush {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            return YES;
        }
    }
    return NO;
}

@end
