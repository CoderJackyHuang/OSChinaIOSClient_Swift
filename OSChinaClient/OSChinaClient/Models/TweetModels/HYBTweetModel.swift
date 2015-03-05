//
//  HYBTweetModel.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 问答模块中的问答、分享、综合、职业、站务对应的数据模型
///
class HYBTweetModel: HYBBaseModel {
  var id = 0
  var portrait = ""
  var author = ""
  var authorid = 0
  var body = ""
  var commentCount = 0
  var pubDate = ""
  var attach = 0
  var appclient = 0
  var imgSmall = ""
  var imgBig = ""
}