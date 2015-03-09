//
//  HYBParentTableController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 在HYBBaseController类提供的公共基础功能上，额外提供更简单的表格加载显示数据功能
///
class HYBParentTableController : HYBBaseController, UITableViewDelegate, UITableViewDataSource {
  ///
  /// 数据源，已经初始化分配好内存
  ///
  var datasource = NSMutableArray();
  
  ///
  /// 表格对象,默认样式为Plain，可空类型，如果不需要使用，就不要调用init相关方法
  ///
  var tableView: UITableView!;
  
  ///
  /// 默认样式为Plain
  ///
  private var style = UITableViewStyle.Plain;
  
  ///
  /// 调用此方法来创建控制器对象，才能获取到tableView
  ///
  init(tableViewStyle: UITableViewStyle = UITableViewStyle.Plain) {
    super.init();
    
    self.style = tableViewStyle;
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nil, bundle: nil);
  }
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    if self.tableView == nil {
      self.tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kMiddleScreenHeight), style: self.style);
      self.view.addSubview(self.tableView!);
      self.tableView.showsHorizontalScrollIndicator = false;
      self.tableView.showsVerticalScrollIndicator = false;
      self.tableView.pagingEnabled = false;
    }
    
    self.tableView?.delegate = self;
    self.tableView?.dataSource = self;
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.datasource.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("UITableViewCellIdentifier");
    
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCellIdentifier");
    }
    
    return cell as UITableViewCell;
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if tableView.style == UITableViewStyle.Plain {
      return 0;
    }
    
    if section != 0 {
      return 5;
    }
    return 25;
  }
  
  
}