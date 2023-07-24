# LarkSR - ios wkwebview demo

Show ios webview open LarkSR Web client.

Links：

[Paraverse](https://www.paraverse.cc/)

[LarkSR Doc](https://www.pingxingyun.com/devCenter.html)

[Experience](https://www.paraverse.cc/)

## Code

### notice: use WKWebView not UIWebView

### WKWebView Config

```oc
// create config
WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];

// request, makesure play video inline mode.
config.allowsInlineMediaPlayback = YES;

// requst, auto play video
config.requiresUserActionForMediaPlayback = NO;
config.mediaTypesRequiringUserActionForPlayback = NO;
```

### Ignore certificate verification

LarkSR support HTTPS, but if a self-signed certificate load failed, can igonre certificate verification

Setup WKNavigationDelegate

```oc
// Ignore certificate verification
-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}
```
