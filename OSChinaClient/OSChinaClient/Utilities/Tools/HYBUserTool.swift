//
//  HYBUserTool.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 用户登录后，会存储和操作用户的信息数据，都会放到此工具类中操作
///
class HYBUserTool {
  ///
  /// 调用此方法来保存请求回来的数据
  ///
  /// model 登录后从服务器取回的数据模型
  ///
  class func save(model: HYBLoginUserModel) {
    kUserDefaults.setObject(model.uid, forKey: "kUidKey");
    kUserDefaults.synchronize();
  }
  
  /// 
  /// 获取用户的id
  ///
  class func uid() -> Int {
    var uid = kUserDefaults.integerForKey("kUidKey");
    return uid;
  }
}