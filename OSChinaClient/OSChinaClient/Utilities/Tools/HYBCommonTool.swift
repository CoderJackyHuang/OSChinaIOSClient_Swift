//
//  HYBCommonTool.swift
//  OSChinaClient
//
//  Created by huangyibiao on 15/3/7.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 公共通用方法铺助类
///
class HYBCommonTool {
  ///
  /// 打开URL
  ///
  /// url 可空类型，如果为空类型，则不执行，否则会打开链接
  ///
  class func openURL(url: String?) {
    if url?.isEmpty == false {
      UIApplication.sharedApplication().openURL(NSURL(string: url!)!);
    }
  }
  
  ///
  /// 获取本地app的版本号
  ///
  /// return 返回app本地版本号
  ///
  class func appVersion() -> String {
    let infoDict = NSBundle.mainBundle().infoDictionary
    
    var version = "1.0";
    if let dict = infoDict {
      version = dict["CFBundleShortVersionString"] as String;
    }

    return version;
  }
}