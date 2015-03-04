//
//  TBXMLExt.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 扩展TBXML，简化访问节点的操作
///
extension TBXML {
  ///
  /// 获取节点值
  ///
  /// name 节点名称
  ///
  /// parent 节点所在的你节点对象
  ///
  /// 返回值：节点的内容
  class func text(name: String, parent: UnsafeMutablePointer<TBXMLElement>) -> String {
    let valueObject = TBXML.childElementNamed(name, parentElement: parent);
    return TBXML.textForElement(valueObject);
  }
  
  ///
  /// 获取节点整型值
  ///
  /// name 节点名称
  ///
  /// parent 节点所在的你节点对象
  ///
  /// 返回值：节点的内容
  class func intValue(name: String, parent: UnsafeMutablePointer<TBXMLElement>) -> Int {
    let text = self.text(name, parent: parent);
    
    var result = 0;
    if let value = text.toInt() {
      result = value;
    }
    
    return result;
  }
}