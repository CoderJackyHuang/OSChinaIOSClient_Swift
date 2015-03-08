//
//  HYBRequestExtensionMore.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import Foundation
import UIKit

typealias SuccessLoginBlock = (model: HYBLoginUserModel) -> ()

///
/// 更多模块
/// 所有在更多模块中使用的网络请求接口处理都放到此扩展文件中，便于分类管理
///
extension HYBBaseRequest {
  ///
  /// 登录接口
  ///
  class func login(url: String, params:[String : AnyObject]?, success: SuccessLoginBlock, fail: FailBlock) -> Request {
    let req = self.Post(url, params: params, success: { (responseObject) -> Void in
      let xml = TBXML(XMLString: responseObject, error: nil);
      let root = xml.rootXMLElement;
      let model = HYBLoginUserModel();
      model.result(root);
      
      if model.errorCode == 1 { // 成功
        let user = TBXML.childElementNamed("user", parentElement: root);
        model.uid = TBXML.text("uid", parent: user);
        model.location = TBXML.text("location", parent: user);
        model.name = TBXML.text("name", parent: user);
        model.followers = TBXML.intValue("followers", parent: user);
        model.fans = TBXML.intValue("fans", parent: user);
        model.score = TBXML.intValue("score", parent: user);
        model.favoritecount = TBXML.intValue("favoritecount", parent: user);
        model.portrait = TBXML.text("portrait", parent: user);
        model.gender = TBXML.intValue("gender", parent: user);
        
        let notice = TBXML.childElementNamed("notice", parentElement: root);
        model.atmeCount = TBXML.intValue("atmeCount", parent: notice);
        model.msgCount = TBXML.intValue("msgCount", parent: notice);
        model.reviewCount = TBXML.intValue("reviewCount", parent: notice);
        model.newFansCount = TBXML.intValue("newFansCount", parent: notice);
      }
      
      success(model: model);
    }) { (error) -> Void in
      fail(error: error);
    };
    
    return req;
  }
  
  ///
  /// 从服务器中检查IOS版本
  ///
  class func checkVersion(url: String, success: SuccessBoolBlock, fail: FailBlock) -> Request {
    let req = self.Get(url, success: { (responseObject) -> Void in
      let xml = TBXML(XMLString: responseObject, error: nil);
      let root = xml.rootXMLElement;
      
      if root == nil {
        success(responseObject: false);
        return;
      }
      
      let update = TBXML.childElementNamed("update", parentElement: root);
      if update == nil {
        success(responseObject: false);
        return;
      }
      
      let version = TBXML.text("ios", parent: update);
      if version > HYBCommonTool.appVersion() {
        success(responseObject: true);
      } else {
        success(responseObject: false);
      }
    }) { (error) -> Void in
      fail(error: error);
    };
    
    return req;
  }
  
  ///
  /// 软件列表接口
  ///
  class func softwareList(url: String, params:[String : AnyObject]?, success: SuccessListBlock, fail: FailBlock) -> Request {
    let req = self.Post(url, params: params, success: { (responseObject) -> Void in
      let xml = TBXML(XMLString: responseObject, error: nil);
      let root = xml.rootXMLElement;

      if root == nil {
        success(nil);
        return;
      }
      
      let softwares = TBXML.childElementNamed("softwares", parentElement: root);
      if softwares == nil {
        success(nil);
        return;
      }
      
      var software = TBXML.childElementNamed("software", parentElement: softwares);
      var modelList = Array<AnyObject>();
      while software != nil {
        let model = HYBSoftwareModel();
        model.name = TBXML.text("name", parent: software);
        model.desc = TBXML.text("description", parent: software);
        model.url = TBXML.text("url", parent: software);
        
        modelList.append(model);
        software = TBXML.nextSiblingNamed("software", searchFromElement: software);
      }
      
      success(modelList);
      }) { (error) -> Void in
        fail(error: error);
    };
    
    return req;
  }
}
