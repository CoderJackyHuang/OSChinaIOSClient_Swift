//
//  HYBLoginController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 登录模块
///
class HYBLoginController: HYBBaseController, UIWebViewDelegate {
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var webView: UIWebView!

  /// 是否记住我，默认为true
  private var isRememberMe = true;
  
  ///
  /// 滑动记住我事件响应
  ///
  @IBAction func onRemeberMeValueChanged(sender: UISwitch) {
    isRememberMe = sender.on;
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "HYBLoginController", bundle: nil);
  }
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.title = "登录";
    self.addItem("登录", isLeft: false);
    self.addItem(imageName: "close", isLeft: true);
    
    self.webView.delegate = self;
    self.webView.backgroundColor = UIColor.whiteColor();
    let html = "<body style='background-color:#EBEBF3'>1, 您可以在 <a href='http://www.oschina.net'>http://www.oschina.net</a> 上免费注册一个账号用来登陆<p />2, 如果您的账号是使用OpenID的方式注册的，那么建议您在网页上为账号设置密码<p />3, 您可以点击 <a href='http://www.oschina.net/question/12_52232'>这里</a> 了解更多关于手机客户端登录的问题</body>";
    self.webView.loadHTMLString(html, baseURL: nil);
    self.webView.hidden = false;
  }
  
  override func onNavRightItemClicked(sender: UIButton) {
    
  }
  
  override func onNavLeftItemClicked(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil);
  }
  
  ///
  /// UIWebViewDelegate
  ///
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    UIApplication.sharedApplication().openURL(request.URL);
    
    if request.URL.absoluteString == "about:blank" {
      return true;
    }
    
    return false;
  }
}
