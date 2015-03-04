//
//  HYBLoginUserModel.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 登录用户的信息数据模型
///
class HYBLoginUserModel: HYBBaseModel {
  /// user节点
  var uid: String = ""
  var location: String = ""
  var name: String = ""
  var followers = 0
  var fans = 0
  var score = 0
  var portrait: String = ""
  var favoritecount = 0
  var gender = 1
  
  /// notice节点
  var atmeCount = 0
  var msgCount = 0
  var reviewCount = 0
  var newFansCount = 0
  
  /// result 节点
  ///
  /// errorCode = 1表示成功
  ///
  var errorCode = 0
  var errorMessage: String = ""
  
  ///
  /// 处理result结果节点数据
  ///
  func result(root: UnsafeMutablePointer<TBXMLElement>) {
    let result = TBXML.childElementNamed("result", parentElement: root)
    
    self.errorCode = TBXML.intValue("errorCode", parent: result);
    self.errorMessage = TBXML.text("errorMessage", parent: result);
  }
  
  ///
  /// 获取请求数据是否成功
  ///
  func isSuccess() -> Bool {
    return self.errorCode == 1;
  }
}
