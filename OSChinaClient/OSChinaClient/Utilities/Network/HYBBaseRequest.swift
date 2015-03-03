//
//  HYBBaseRequest.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

typealias SuccessBlock = (responseObject: AnyObject?) -> Void;
typealias FailBlock = (error: NSError?) -> Void;

///
/// 网络请求API封装
///
class HYBBaseRequest {
  class func Get(url: String, params:[String: AnyObject]?, success: SuccessBlock, fail: FailBlock) -> Request {
    let op = Manager.sharedInstance.request(Method.GET,
      url,
      parameters: params,
      encoding: ParameterEncoding.JSON).responseJSON { (request, responseObject, object, error) -> Void in
        
    };
    return op;
  }
}