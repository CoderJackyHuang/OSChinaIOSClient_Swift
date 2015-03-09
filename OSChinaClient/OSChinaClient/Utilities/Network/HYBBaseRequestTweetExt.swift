//
//  HYBBaseRequestTweetExt.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 动弹模块
/// 所有在动弹模块中使用的网络请求接口处理都放到此扩展文件中，便于分类管理
///
extension HYBBaseRequest {
  ///
  /// 获取最新动弹、热门动弹、我的动弹的接口
  ///
  typealias SuccessListBlock = ([AnyObject]?) -> ();
  class func tweetList(url: String, success: SuccessListBlock, fail: FailBlock) -> Request {
    let req = self.Get(url, success: { (responseObject) -> Void in
      ///
      /// Alamofire网络请求库，在请求这个接口的XML数据时，在将data转换成String时，数据是完整的，
      /// 但当serializer成AnyObject?类型后，只有一条半的数据了，具体原因不明，当前未找到好的解决方案
      /// 这里就留给喜欢研究的朋友
      let xml = TBXML(XMLString: responseObject, error: nil);
      let root = xml.rootXMLElement;
      let tweets = TBXML.childElementNamed("tweets", parentElement: root);
      
      if tweets == nil {
        success(nil);
      } else {
        var tweet = TBXML.childElementNamed("tweet", parentElement: tweets);
        var resultArray = NSMutableArray();
        
        while tweet != nil {
          let model = HYBTweetModel();
          
          model.id = TBXML.intValue("id", parent: tweet);
          model.imgBig = TBXML.text("imgBig", parent: tweet);
          model.commentCount = TBXML.intValue("commentCount", parent: tweet);
          model.author = TBXML.text("author", parent: tweet);
          model.authorid = TBXML.intValue("authorid", parent: tweet);
          model.pubDate = TBXML.text("pubDate", parent: tweet);
          model.imgSmall = TBXML.text("imgSmall", parent: tweet);
          model.body = TBXML.text("body", parent: tweet);
          model.portrait = TBXML.text("portrait", parent: tweet);
          model.attach = TBXML.intValue("attach", parent: tweet);
          model.appclient = TBXML.intValue("appclient", parent: tweet);
          
          resultArray.addObject(model);
          
          // 搜索下一个
          tweet = TBXML.nextSiblingNamed("tweet", searchFromElement: tweets);
        }
        
        success(resultArray);
      }
      }) { (error) -> Void in
        fail(error: error);
    };
    return req;
  }
}