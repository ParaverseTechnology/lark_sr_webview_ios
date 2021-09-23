//
//  ViewController.m
//  lark_sr_webview
//
//  Created by fcx@pingxingyun on 2021/9/23.
//

#import "ViewController.h"

//#define USE_UI_WEBVIEW

@interface ViewController ()<WKNavigationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     // 创建请求
     // 平行云演示地址 cloudlark.pingxingyun.com:8180
     // 测试应用 ID 879414254636105728
     NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://cloudlark.pingxingyun.com:8180/enterAppli?appliId=879414254636105728"]];
//    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://cloudlark.pingxingyun.com:8180"]];
#ifdef USE_UI_WEBVIEW
    ui_webview_ = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // 加载网页
    [ui_webview_ loadRequest:request];
    // 最后将webView添加到界面
    [self.view addSubview: ui_webview_];
#else
    //创建网页配置对象
     WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
     
     // 创建设置对象
     WKPreferences *preference = [[WKPreferences alloc]init];
     // 最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
     preference.minimumFontSize = 0;
     //设置是否支持javaScript 默认是支持的
     preference.javaScriptEnabled = YES;
     // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
     preference.javaScriptCanOpenWindowsAutomatically = YES;
     config.preferences = preference;
     
     // 必要设置，可以 lark 视频层和 ui 层能正确展示
     config.allowsInlineMediaPlayback = YES;
     
     // 必要设置，设置视频是否需要用户手动播放。不设置可能出现 5/5 视频不播放的问题
     config.requiresUserActionForMediaPlayback = NO;
     config.mediaTypesRequiringUserActionForPlayback = NO;
    
     //设置是否允许画中画技术 在特定设备上有效
     config.allowsPictureInPictureMediaPlayback = YES;
     //设置请求的User-Agent信息中应用程序名称 iOS9后可用
     config.applicationNameForUserAgent = @"PXYWebView";

    wk_webview_ = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
    wk_webview_.navigationDelegate = self;
    [wk_webview_ loadRequest:request];
    [self.view addSubview: wk_webview_];
#endif
}

// 忽略证书验证
-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}
@end
