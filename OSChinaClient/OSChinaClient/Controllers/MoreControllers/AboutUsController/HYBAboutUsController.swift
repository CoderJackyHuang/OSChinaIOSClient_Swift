//
//  HYBAboutUsController.swift
//  OSChinaClient
//
//  Created by huangyibiao on 15/3/7.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 关于我们模块
///
class HYBAboutUsController: HYBBaseController {
  /// 显示app版本号
  @IBOutlet weak var appVersionLabel: UILabel!
  /// 背景图片
  @IBOutlet weak var backgroundImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.addItem("手机版", isLeft: false);
    self.title = "关于我们";
    
    self.backgroundImageView.image = UIImage(named: "aboutbg1136.jpg");
    self.appVersionLabel.text = String(format: "app版本：%@", HYBCommonTool.appVersion());
  }
  
  override func onNavRightItemClicked(sender: UIButton) {
    UIApplication.sharedApplication().openURL(NSURL(string: "http://m.oschina.net")!);
  }
}
