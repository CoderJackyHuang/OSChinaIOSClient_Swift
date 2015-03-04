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
  
  ///
  /// 当前正在请求中的请求对象
  ///
  var currentRequest: Request? {
    willSet {
      self.lastCancelRequest = self.currentRequest;
    }
  }
  
  ///
  /// 最后一次取消请求的请求对象
  ///
  var lastCancelRequest: Request? {
    willSet {
      self.currentRequest?.cancel();
    }
  }
  
  ///
  /// 生成导航标题栏，使用UISegmentedControl对象，只需要传标题数组
  /// 然后事件回调是在onSelectedTitleControl方法中
  var titleControl: UISegmentedControl?
  func titleView(items:[String], selectedIndex: Int = 0) {
    self.titleControl = UISegmentedControl(items: items);
    self.titleControl?.selectedSegmentIndex = 0;
    self.titleControl?.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
    self.titleControl?.frame = CGRectMake(0, 7, kScreenWidth - 20, kNavBarHeight - 14);
    self.titleControl?.addTarget(self,
      action: "onSelectedTitleControl:",
      forControlEvents: UIControlEvents.ValueChanged);
    self.navigationItem.titleView = self.titleControl;
  }
  
  ///
  /// 点击导航上的标题栏中的某一项的回调
  ///
  func onSelectedTitleControl(sender: UISegmentedControl) {
    print("子类需要重写");
  }
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    // 去掉空白区域
    self.automaticallyAdjustsScrollViewInsets = false;
    // 透明状态栏的延伸
    self.edgesForExtendedLayout = UIRectEdge.None;
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated);
    
    self.currentRequest?.cancel();
    HYBProgressHUD.dismiss();
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
  /// 显示网络错误提示
  ///
  func showNetError(error: NSError?) {
    HYBProgressHUD.dismiss();
    
    if error == nil {
      HYBProgressHUD.showError("网络异常");
      return;
    }
    
    if error!.code == -1001 {
      HYBProgressHUD.showError("请求超时");
    } else if error!.code == -999 {
      print("手动取消请求");
    } else if (!error!.domain.isEmpty) {
      HYBProgressHUD.showError("网络异常");
    }
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
  /// 设置导航右上角按钮是否可用
  ///
  func setRightItem(enabled: Bool) {
    self.navigationItem.rightBarButtonItem?.enabled = enabled;
  }
  ///
  /// 设置导航左上角按钮是否可用
  ///
  func setLeftItem(enabled: Bool) {
    self.navigationItem.leftBarButtonItem?.enabled = enabled;
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