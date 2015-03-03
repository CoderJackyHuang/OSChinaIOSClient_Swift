//
//  HYBRootTabBarController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 程序窗口的入口，包含综合模块、问答模块、动弹模块、我的模块、更多模块，生成此类的实例，
/// 作为window的rootViewController
///
class HYBRootTabBarController : UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.viewControllers = [self.nav(type: 0), self.nav(type: 1),
      self.nav(type: 2), self.nav(type: 3), self.nav(type: 4)];
  }
  
  private func nav(var type: Int = 0) -> UINavigationController! {
    switch (type) {
    case 0:
      /// 综合
      let controller = HYBSynthesizeController();
      controller.tabBarItem.image = UIImage(named: "synthesize");
      controller.tabBarItem.title = "综合";
      let synNav = UINavigationController(rootViewController: controller);
      return synNav;
    case 1:
      /// 问答
      let controller = HYBAnswerController();
      controller.tabBarItem.image = UIImage(named: "answer");
      controller.tabBarItem.title = "问答";
      let synNav = UINavigationController(rootViewController: controller);
      return synNav;
    case 2:
      /// 动弹
      let controller = HYBTweetController();
      controller.tabBarItem.image = UIImage(named: "tweet");
      controller.tabBarItem.title = "动弹";
      let synNav = UINavigationController(rootViewController: controller);
      return synNav;
    case 3:
      /// 我的
      let controller = HYBMineController();
      controller.tabBarItem.image = UIImage(named: "my");
      controller.tabBarItem.title = "我的";
      let synNav = UINavigationController(rootViewController: controller);
      return synNav;
    case 4:
      /// 更多
      let controller = HYBMoreController(tableViewStyle: UITableViewStyle.Grouped);
      controller.tabBarItem.image = UIImage(named: "more");
      controller.tabBarItem.title = "更多";
      let synNav = UINavigationController(rootViewController: controller);
      return synNav;
    default:
      break;
    }
    return nil;
  }
}