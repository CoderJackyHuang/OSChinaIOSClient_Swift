//
//  HYBBaseRequestAnswerExt.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 问答模块
/// 所有在问答模块中使用的网络请求接口处理都放到此扩展文件中，便于分类管理
///
extension HYBBaseRequest {
  ///
  /// 获取问答、分享、综合、职业、站务的接口
  ///
  typealias SuccessPostListBlock = ([AnyObject]?) -> ();
  class func postList(url: String, success: SuccessPostListBlock, fail: FailBlock) -> Request {
    let req = self.Get(url, success: { (responseObject) -> Void in
      let xml = TBXML(XMLString: responseObject, error: nil);
      let root = xml.rootXMLElement;
      let posts = TBXML.childElementNamed("posts", parentElement: root);
      
      if posts == nil {
        success(nil);
      } else {
        var post = TBXML.childElementNamed("post", parentElement: posts);
        var resultArray = NSMutableArray();
        
        while post != nil {
          let model = HYBPostModel();
          model.id = TBXML.intValue("id", parent: post);
          model.title = TBXML.text("title", parent: post);
          model.answerCount = TBXML.intValue("answerCount", parent: post);
          model.author = TBXML.text("author", parent: post);
          model.authorid = TBXML.intValue("authorid", parent: post);
          model.pubDate = TBXML.text("pubDate", parent: post);
          model.viewCount = TBXML.intValue("viewCount", parent: post);
          model.body = TBXML.text("body", parent: post);
          model.portrait = TBXML.text("portrait", parent: post);
          
          resultArray.addObject(model);
          
          // 搜索下一个
          post = TBXML.nextSiblingNamed("post", searchFromElement: post);
        }
        
        success(resultArray);
      }

    }) { (error) -> Void in
         fail(error: error);
    };
    return req;
  }
}