//
//  HYBMoreController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 更多模块
/// 包含扫一扫、登录、注销、查看软件、搜索、意见反馈、官方微博、关于我们、检查更新、给我评分子功能
///
class HYBMoreController: HYBParentTableController, UIAlertViewDelegate {
  override func viewDidLoad() {
    super.viewDidLoad();
    
    let secOne = [["name" : "登录", "imgName" : "account"],
      ["name" : "扫一扫", "imgName" : "scan"],
      ["name" : "注销", "imgName" : "exit"]];
    
    let secTwo = [
      ["name" : "软件", "imgName" : "software"],
      ["name" : "搜索", "imgName" : "search"]];
    
    let secThree = [
      ["name" : "意见反馈", "imgName" : "feedback"],
      ["name" : "官方微博", "imgName" : "weibo"],
      ["name" : "关于我们", "imgName" : "aboutus"],
      ["name" : "检查更新", "imgName" : "setting"],
      ["name" : "给我评分", "imgName" : "rating"]];
    
    self.datasource.addObject(secOne);
    self.datasource.addObject(secTwo);
    self.datasource.addObject(secThree);
    
    self.title = "更多";
  }
  
  ///
  /// UITableViewDataSource
  ///
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.datasource.count;
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let array = self.datasource.objectAtIndex(section) as NSArray;
    return array.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell;
    
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: kCellIdentifier);
    }
    
    if indexPath.section < self.datasource.count {
      let array = self.datasource.objectAtIndex(indexPath.section) as NSArray;
      if indexPath.row < array.count {
        let dict = array.objectAtIndex(indexPath.row) as NSDictionary;
        cell?.imageView?.image = UIImage(named: dict["imgName"] as String);
        cell?.textLabel?.text = dict["name"] as? String;
      }
    }
    
    return cell!;
  }
  
  ///
  /// UITableViewDelegate
  ///
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch (indexPath.section) {
    case 0: // section 0
      switch (indexPath.row) {
      case 0:// 登录
        let loginController = HYBLoginController(nibName: "HYBLoginController", bundle: nil);
        loginController.show(self, completion: { (result) -> () in
          if result { // 登录成功
            
          }
        });
        break;
      case 1:
        break;
      case 2:
        break;
      default:
        break;
      }
      break;
    case 1: // section 1
      if indexPath.row == 0 { // 软件
        let controller = HYBSoftwareController();
        controller.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(controller, animated: true);
      } else { // 搜索
        
      }
      break;
    case 2: // section 2
      switch (indexPath.row) {
      case 0:// 意见反馈
        HYBCommonTool.openURL("mailto:oschina.net@gmail.com");
      break;
      case 1: // 官方微博
        HYBCommonTool.openURL("http://www.weibo.com/oschina2010");
        break;
      case 2: // 关于我们
        let us = HYBAboutUsController(nibName: "HYBAboutUsController", bundle: nil);
        us.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(us, animated: true);
        break;
      case 3: // 检查更新
        self.currentRequest = HYBBaseRequest.checkVersion(kApiVersionCheck, success: { (responseObject) -> Void in
          if responseObject == true {
            let alert = UIAlertView(title: "温馨提示", message: "开源中国iPhone客户端有新版了\n您需要下载吗?", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定");
            alert.show();
          } else {
            let alert = UIAlertView(title: "", message: "当前已经是最新版本", delegate: nil, cancelButtonTitle: "确定");
            alert.show();
          }
          }, fail: { (error) -> Void in
            self.showNetError(error);
        });
        break;
      default: // 给我们评分
        HYBCommonTool.openURL("itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=524298520");
        break;
      }

      break;
    default:
      break;
    }
  }
  
  ///
  /// UIAlertViewDelegate
  ///
  func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    if buttonIndex == 1 {
      HYBCommonTool.openURL("itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=524298520");
    }
  }
}