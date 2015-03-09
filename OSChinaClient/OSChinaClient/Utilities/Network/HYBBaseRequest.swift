//
//  HYBBaseRequest.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/3.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

typealias SuccessBlock = (responseObject: NSString?) -> Void;
typealias FailBlock = (error: NSError?) -> Void;

///
/// 网络请求API封装
///
class HYBBaseRequest {
  class func Get(url: String, success: SuccessBlock, fail: FailBlock) -> Request {
    return self.Get(url, params: nil, success: success, fail: fail);
  }
  
  class func Get(url: String, params:[String: AnyObject]?, success: SuccessBlock, fail: FailBlock) -> Request {
    let op = Manager.sharedInstance.request(Method.GET,
      self.baseUrl(url),
      parameters: params,
      encoding: ParameterEncoding.URL)
      .responseString(encoding: NSUTF8StringEncoding) { (request, response, str, error) -> Void in
        
        if error == nil {
          println("success：" + request.URLString);
          
          success(responseObject: str);
        } else {
          println("error：" + url);
          fail(error: error);
        }
    }
    
    return op;
  }
  
  class func Post(url: String, params:[String: AnyObject]?, success: SuccessBlock, fail: FailBlock) -> Request {
    let op = Manager.sharedInstance.request(Method.POST,
      self.baseUrl(url),
      parameters: params,
      encoding: ParameterEncoding.URL).responseString { (request, response, responseObject, error) -> Void in
        if error == nil {
          println("success：" + request.URLString);
          success(responseObject: responseObject);
        } else {
          println("error：" + url)
          fail(error: error);
        }
    }
    
    return op;
  }
  
  private class func baseUrl(url: String) -> String {
    if url.hasPrefix("http://") || url.hasPrefix("https://") {
      return url;
    }
    
    return String(format: "%@%@", kServerBase, url);
  }
}