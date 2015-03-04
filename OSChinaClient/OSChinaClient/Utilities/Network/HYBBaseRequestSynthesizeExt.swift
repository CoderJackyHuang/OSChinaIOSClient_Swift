//
//  HYBBaseRequestSynthesizeExt.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation

///
/// 综合模块
/// 所有在综合模块中使用的网络请求接口处理都放到此扩展文件中，便于分类管理
///
extension HYBBaseRequest {
  ///
  /// 获取资讯、博客 、推荐阅读的接口
  ///
  typealias SuccessNewsListBlock = ([AnyObject]?) -> ();
  class func newsList(type: Int, url: String, success: SuccessNewsListBlock, fail: FailBlock) -> Request {
    let req = self.Get(url, success: { (responseObject) -> Void in
      let xml = TBXML(XMLString: responseObject, error: nil);
      let root = xml.rootXMLElement;
      
      if type == 0 || type == 2 {
        let newslist = TBXML.childElementNamed("newslist", parentElement: root);
        
        if newslist == nil {
          success(nil);
        } else {
          var news = TBXML.childElementNamed("news", parentElement: newslist);
          var resultArray = NSMutableArray();
          
          while news != nil {
            let model = HYBNewsModel();
            model.id = TBXML.intValue("id", parent: news);
            model.title = TBXML.text("title", parent: news);
            model.commentCount = TBXML.intValue("commentCount", parent: news);
            model.author = TBXML.text("author", parent: news);
            model.authorid = TBXML.intValue("authorid", parent: news);
            model.pubDate = TBXML.text("pubDate", parent: news);
            model.url = TBXML.text("url", parent: news);
            model.body = TBXML.text("body", parent: news);
            
            // newstype
            let newstype = TBXML.childElementNamed("newstype", parentElement: news);
            model.type = TBXML.intValue("type", parent: newstype);
            model.authoruid2 = TBXML.intValue("authoruid2", parent: newstype);
            model.eventurl = TBXML.text("eventurl", parent: newstype);
            
            resultArray.addObject(model);
            
            // 搜索下一个
            news = TBXML.nextSiblingNamed("news", searchFromElement: news);
          }
          
          success(resultArray);
        }
      } else {
        let blogs = TBXML.childElementNamed("blogs", parentElement: root);
        
        if blogs == nil {
          success(nil);
        } else {
          var blog = TBXML.childElementNamed("blog", parentElement: blogs);
          var resultArray = NSMutableArray();
          
          while blog != nil {
            let model = HYBBlogModel();
            model.id = TBXML.intValue("id", parent: blog);
            model.title = TBXML.text("title", parent: blog);
            model.commentCount = TBXML.intValue("commentCount", parent: blog);
            model.authoruid = TBXML.intValue("authoruid", parent: blog);
            model.pubDate = TBXML.text("pubDate", parent: blog);
            model.url = TBXML.text("url", parent: blog);
            model.documentType = TBXML.intValue("documentType", parent: blog);
            model.authorname = TBXML.text("authorname", parent: blog);
            model.body = TBXML.text("body", parent: blog);
            resultArray.addObject(model);
            
            // 搜索下一个
            blog = TBXML.nextSiblingNamed("blog", searchFromElement: blog);
          }
          
          success(resultArray);
        }
      }
      }) { (error) -> Void in
        fail(error: error);
    };
    
    return req;
  }
}