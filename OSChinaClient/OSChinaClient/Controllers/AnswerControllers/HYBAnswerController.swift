//
//  HYBAnswerController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 问答模块
/// 包含问答、分享、综合、职业、站务、发表问答子功能
///
class HYBAnswerController: HYBRefreshController {
  ///
  /// 初始化
  ///
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.titleView(["问答", "分享", "综合", "职业", "站务"], selectedIndex: 0);
    self.addItem(imageName: "questionBlue", isLeft: false);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kMiddleScreenHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
    self.addHeaderRefresh(support: true);
    self.addFooterLoadMore(support: true);
    
    self.beginHeaderRefreshing();
  }
  
  func url() -> String {
    return String(format: "%@?catalog=%d&pageIndex=%d&pageSize=20",
      kApiPostList,
      self.titleControl!.selectedSegmentIndex + 1,
      self.currentPage);
  }
  
  override func onSelectedTitleControl(sender: UISegmentedControl) {
    self.beginHeaderRefreshing();
  }
  
  override func headerRefresh() {
    super.headerRefresh();
    
    self.currentRequest = HYBBaseRequest.postList(self.url(), success: { (models) -> () in
      if models == nil {
        HYBProgressHUD.showError("加载失败");
      } else {
        self.datasource.removeAllObjects();
        self.datasource.addObjectsFromArray(models!);
        self.tableView.reloadData();
      }
      self.endHeaderRefreshing();
      }, fail: { (error) -> Void in
        self.showNetError(error);
        self.endHeaderRefreshing();
    });
  }
  
  override func footerLoadMore() {
    super.footerLoadMore();
    
    self.currentRequest = HYBBaseRequest.postList(self.url(), success: { (models) -> () in
      if models == nil {
        self.endFooterLoadMore(success: false);
        HYBProgressHUD.showError("加载失败");
      } else {
        self.datasource.addObjectsFromArray(models!);
        self.tableView.reloadData();
        self.endFooterLoadMore();
      }
      }, fail: { (error) -> Void in
        self.showNetError(error);
        self.endFooterLoadMore(success: false);
    });
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: HYBPostCell? = tableView.dequeueReusableCellWithIdentifier(kPostCellIdentifier) as? HYBPostCell;
    
    if cell == nil {
      cell = NSBundle.mainBundle().loadNibNamed("HYBPostCell", owner: self, options: nil).last as? HYBPostCell;
    }
    
    if indexPath.row < self.datasource.count {
      let model = self.datasource.objectAtIndex(indexPath.row) as? HYBPostModel;
      cell?.model = model;
    }
    
    return cell!;
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 65;
  }

}