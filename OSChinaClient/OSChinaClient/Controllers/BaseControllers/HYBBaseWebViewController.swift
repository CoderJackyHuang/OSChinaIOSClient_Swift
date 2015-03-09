//
//  HYBBaseWebViewController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/6.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 在HYBBaseController所提供的基础上，额外提供Webview加载的功能
///
class HYBBaseWebViewController : HYBBaseController, UIWebViewDelegate {
  ///
  /// 获取webview对象
  ///
  var webView = UIWebView(frame: CGRectMake(0, 0, kScreenWidth, kMiddleScreenHeight));
  
  var url: String {
    didSet {
      // 发起请求
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.view.addSubview(self.webView);
    self.webView.delegate = self;
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated);
    
    self.webView.stopLoading();
  }
  
  ///
  /// UIWebViewDelegate
  ///

}