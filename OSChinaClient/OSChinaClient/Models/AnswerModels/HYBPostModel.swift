//
//  HYBPostModel.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 问答模块中的问答、分享、综合、职业、站务对应的数据模型
///
class HYBPostModel: HYBBaseModel {
  var id = 0
  var portrait = ""
  var author = ""
  var authorid = 0
  var title = ""
  var body = ""
  var answerCount = 0
  var viewCount = 0
  var pubDate = ""
}
