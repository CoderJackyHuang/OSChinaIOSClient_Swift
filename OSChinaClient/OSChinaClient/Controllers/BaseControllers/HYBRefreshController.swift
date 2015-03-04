//
//  HYBRefreshController.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

///
/// 在HYBParentTableController提供的表格功能基础上，追加自动上拉加载更多和下拉刷新功能
///
class HYBRefreshController: HYBParentTableController {
  /// 当前第几页，从1开始计算，1表示第一页
  var currentPage = 1;
  
  /// 表示是否正在加载数据中,默认为false
  var isLoadingData = false;
  
  /// 添加下拉刷新或者上拉加载更多功能的scrollview
  private var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView?) {
    super.init(nibName: nil, bundle: nil);

      self.scrollView = scrollView;
  }
  
  convenience init() {
    self.init(scrollView: nil);
  }
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    if self.scrollView == nil {
      self.scrollView = self.tableView;
    }
  }
  
  ///
  /// 支持下拉刷新功能
  ///
  func addHeaderRefresh(support: Bool = true) {
    if support {
      self.tableView.addHeaderWithCallback({ () -> Void in
        self.headerRefresh();
      });
    } else {
      self.scrollView?.removeHeader();
    }
  }
  
  ///
  /// 支持上拉加载更多功能
  ///
  func addFooterLoadMore(support: Bool = true) {
    if support {
      self.tableView.addFooterWithCallback({ () -> Void in
        self.footerLoadMore();
      });
    } else {
      self.scrollView?.removeFooter();
    }
  }
  
  ///
  /// 手动触发下拉刷新
  ///
  func beginHeaderRefreshing() {
    self.scrollView?.headerBeginRefreshing();
    self.isLoadingData = true;
  }
  
  ///
  /// 在刷新完成后，调用此方法来隐藏正在刷新的画面
  ///
  func endHeaderRefreshing() {
    self.scrollView?.headerEndRefreshing();
    self.isLoadingData = false;
  }
  
  
  ///
  /// 手动触发上拉加载更多
  ///
  func beginFooterLoadMore() {
    self.scrollView?.footerBeginRefreshing();
    self.isLoadingData = true;
  }
  
  ///
  /// 在刷新完成后，调用此方法来隐藏正在刷新的画面
  ///
  func endFooterLoadMore(success: Bool = true) {
    self.scrollView?.footerEndRefreshing();
    self.isLoadingData = false;
    
    if !success {
      self.currentPage--;
    }
  }
  
  ///
  /// 下拉刷新回调
  ///
  func headerRefresh() {
    self.isLoadingData = true;
    self.currentPage = 1;
  }
  
  ///
  /// 上拉加载更多回调
  ///
  func footerLoadMore() {
    self.isLoadingData = true;
    self.currentPage++;
  }
}