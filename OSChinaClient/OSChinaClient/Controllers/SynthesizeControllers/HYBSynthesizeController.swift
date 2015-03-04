//
//  HYBSynthesizeController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 综合模块
/// 包含资讯、博客 、推荐阅读子功能，提供搜索功能
///
class HYBSynthesizeController : HYBRefreshController {
  var firstCurPage = 1
  var secondCurPage = 1
  var thirdCurPage = 1
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.titleView(["资讯", "博客", "推荐阅读"], selectedIndex: 0);
    self.addItem(imageName: "searchBlue", isLeft: false);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kMiddleScreenHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
    self.addHeaderRefresh(support: true);
    self.addFooterLoadMore(support: true);
    
    self.beginHeaderRefreshing();
  }
  
  func url(page: Int) -> String {
    var url = "";
    
    switch (self.titleControl!.selectedSegmentIndex) {
    case 1:
      self.secondCurPage = page;
      url = String(format: "%@?type=latest&pageIndex=%d&pageSize=%d",
        kApiBlogList, self.secondCurPage, 20);
      break;
    case 2:
      self.thirdCurPage = page;
      url = String(format: "%@?type=recommend&pageIndex=%d&pageSize=%d",
        kApiNewsList, self.thirdCurPage, 20);
      break;
    default:
      self.firstCurPage = page;
      url = String(format: "%@?catalog=%d&pageIndex=%d&pageSize=%d",
        kApiNewsList, 1, self.firstCurPage, 20);
      break;
    }
    return url;
  }
  
  override func onSelectedTitleControl(sender: UISegmentedControl) {
    self.beginHeaderRefreshing();
  }
  
  override func headerRefresh() {
    super.headerRefresh();

    self.currentRequest = HYBBaseRequest.newsList(self.titleControl!.selectedSegmentIndex, url: self.url(1), success: { (models) -> () in
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
    
    var page = 1;
    if self.titleControl!.selectedSegmentIndex == 1 {
      page = ++self.secondCurPage;
    } else if (self.titleControl!.selectedSegmentIndex == 2) {
      page = ++self.thirdCurPage;
    } else {
      page = ++self.firstCurPage;
    }
    
    self.currentRequest = HYBBaseRequest.newsList(self.titleControl!.selectedSegmentIndex, url: self.url(1), success: { (models) -> () in
      if models == nil {
        self.endFooterLoadMore(success: false);
        HYBProgressHUD.showError("加载失败");
        if self.titleControl!.selectedSegmentIndex == 1 {
          --self.secondCurPage;
        } else if (self.titleControl!.selectedSegmentIndex == 2) {
          --self.thirdCurPage;
        } else {
          --self.firstCurPage;
        }
      } else {
        self.datasource.addObjectsFromArray(models!);
        self.tableView.reloadData();
        self.endFooterLoadMore();
      }
      }, fail: { (error) -> Void in
        if self.titleControl!.selectedSegmentIndex == 1 {
          --self.secondCurPage;
        } else if (self.titleControl!.selectedSegmentIndex == 2) {
          --self.thirdCurPage;
        } else {
          --self.firstCurPage;
        }
        self.showNetError(error);
       self.endFooterLoadMore(success: false);
    });
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: HYBNewsCell? = tableView.dequeueReusableCellWithIdentifier(kNewsCellIdentier) as? HYBNewsCell;
    
    if cell == nil {
      cell = NSBundle.mainBundle().loadNibNamed("HYBNewsCell", owner: self, options: nil).last as? HYBNewsCell;
    }
    
    if indexPath.row < self.datasource.count {
      let model = self.datasource.objectAtIndex(indexPath.row) as? HYBBaseModel;
      cell?.model = model;
    }
    
    return cell!;
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 50;
  }
}
