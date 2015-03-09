//
//  HYBMineController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 我的模块
/// 包含所有信息、给我的、评论、我自己、留言子功能
///
class HYBMineController: HYBRefreshController {
  ///
  /// 初始化
  ///
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.titleView(["所有", "@我", "评论", "我自己", "留言"], selectedIndex: 0);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kMiddleScreenHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
    self.addHeaderRefresh(support: true);
    self.addFooterLoadMore(support: true);
    
    self.beginHeaderRefreshing();
  }
  
  func url() -> String {
    var uid = 0;
    if self.titleControl!.selectedSegmentIndex == 1 {
      uid = -1;
    } else if self.titleControl!.selectedSegmentIndex == 2 {
      uid = HYBUserTool.uid();
    }
    
    return String(format: "%@?uid=%d&pageIndex=%d&pageSize=20",
      kApiTweetList,
      uid,
      self.currentPage-1);
  }
  
  override func onSelectedTitleControl(sender: UISegmentedControl) {
    self.beginHeaderRefreshing();
  }
  
  override func headerRefresh() {
    super.headerRefresh();
    
    self.currentRequest = HYBBaseRequest.tweetList(self.url(), success: { (models) -> () in
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
    
    self.currentRequest = HYBBaseRequest.tweetList(self.url(), success: { (models) -> () in
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
    var cell: HYBTweetCell? = tableView.dequeueReusableCellWithIdentifier(kTweetCellIdentifier) as? HYBTweetCell;
    
    if cell == nil {
      cell = NSBundle.mainBundle().loadNibNamed("HYBTweetCell", owner: self, options: nil).last as? HYBTweetCell;
    }
    
    if indexPath.row < self.datasource.count {
      let model = self.datasource.objectAtIndex(indexPath.row) as? HYBTweetModel;
      cell?.model = model;
    }
    
    return cell!;
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.row >= self.datasource.count {
      return 0;
    }
    
    let model = self.datasource.objectAtIndex(indexPath.row) as HYBTweetModel;
    return HYBTweetCell.cellHeight(model);
  }

}