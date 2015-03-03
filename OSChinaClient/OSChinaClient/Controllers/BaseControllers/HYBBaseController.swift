//
//  HYBBaseController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

typealias HYBLoginBlock = (result: Bool) -> ();

///
/// 最顶层控制器基类，提供公共的API，所有控制器类，都需要直接或者间接继承于此类
///
class HYBBaseController : UIViewController {
  ///
  /// 登录回调block
  ///
  var loginBlock: HYBLoginBlock?
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    // 去掉空白区域
    self.automaticallyAdjustsScrollViewInsets = false;
    // 透明状态栏的延伸
    self.edgesForExtendedLayout = UIRectEdge.None;
  }
  
  ///
  /// 调起模态显示控制器
  ///
  func show(controller: UIViewController!, completion:HYBLoginBlock?) {
    self.loginBlock = completion;
    
    var nav = self.navigationController;
    if nav == nil {
      nav = UINavigationController(rootViewController: self);
    }
    
    controller.presentViewController(nav!, animated: true, completion: nil);
  }
  
  ///
  /// 添加导航条上的左、右按钮
  ///
  /// name 名称
  ///
  /// isLeft 是否是左按钮，默认为true
  func addItem(name: String, isLeft: Bool = true) {
    let item = UIBarButtonItem(title: name,
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: isLeft ? "onNavLeftItemClicked:" : "onNavRightItemClicked:");

    if isLeft {
      self.navigationItem.leftBarButtonItem = item;
    } else {
      self.navigationItem.rightBarButtonItem = item;
    }
  }
  
  ///
  /// 添加导航条上的左、右按钮
  ///
  /// name 名称
  ///
  /// isLeft 是否是左按钮，默认为true
  func addItem(#imageName: String, isLeft: Bool = true) {
    let button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
    button .setImage(UIImage(named: imageName), forState: UIControlState.Normal);
    button .addTarget(self,
      action: isLeft ? "onNavLeftItemClicked:" : "onNavRightItemClicked:",
      forControlEvents: UIControlEvents.TouchUpInside);
    let size = button.imageView?.image?.size;
    button.frame = CGRectMake(0, 0, size!.width, kNavBarHeight);
    let item = UIBarButtonItem(customView: button as UIView);

    if isLeft {
      self.navigationItem.leftBarButtonItem = item;
    } else {
      self.navigationItem.rightBarButtonItem = item;
    }
  }
  
  ///
  /// 点击导航左按钮的回调函数
  ///
  func onNavLeftItemClicked(sender: UIButton) {
    NSLog("子类可以重写onNavLeftItemClicked");
  }
  
  ///
  /// 点击导航右按钮的回调函数
  ///
  func onNavRightItemClicked(sender: UIButton) {
      NSLog("子类可以重写onNavRightItemClicked");
  }
}