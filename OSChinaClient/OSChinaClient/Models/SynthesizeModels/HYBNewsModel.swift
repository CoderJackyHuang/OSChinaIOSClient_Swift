//
//  HYBNewsModel.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 获取资讯、推荐阅读的数据模型
///
class HYBNewsModel: HYBBaseModel {
  var id = 0
  var title = ""
  var body = ""
  var commentCount = 0
  var author = ""
  var authorid = 1
  var pubDate = ""
  var url = ""
  
  /// newstype节点
  var type = 0
  var authoruid2 = 0
  var eventurl = ""
}