//
//  HYBSynthesizeDetailController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/6.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Cocoa

///
/// 资讯详情
///
class HYBSynthesizeDetailController: UITabBarController {
  ///
  /// 必传的数据模型
  ///
  var model: HYBNewsModel?
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.viewControllers = [self.nav(type: 0), self.nav(type: 1),
      self.nav(type: 2)];
  }
  
  private func nav(var type: Int = 0) -> UIViewController! {
    switch (type) {
    case 0:
      // 资讯详情
      let controller = HYBBaseWebViewController();
      controller.tabBarItem.image = UIImage(named: "detail");
      controller.tabBarItem.title = "资讯详情";
      return controller;
    case 1:
      /// 评论
      let controller = HYBCommentListController();
      controller.tabBarItem.image = UIImage(named: "commentList");
      controller.tabBarItem.title = "评论";
      let synNav = UINavigationController(rootViewController: controller);
      return synNav;
    case 2:
      /// 动弹
      let controller = HYBShareController();
      controller.tabBarItem.image = UIImage(named: "share");
      controller.tabBarItem.title = "分享";
      return controller;
    default:
      break;
    }
    return nil;
  }

}
