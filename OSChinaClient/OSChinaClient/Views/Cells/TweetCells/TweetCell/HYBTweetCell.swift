//
//  HYBTweetCell.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 动弹模块中最新动弹、热门老弱病残、我的动弹对应的表格单元
///
class HYBTweetCell: HYBBaseCell {
  @IBOutlet weak var portraitImageView: HYBLoadingImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var commentCountLabel: UILabel!
  @IBOutlet weak var pubDateLabel: UILabel!
  @IBOutlet weak var imgSmall: HYBLoadingImageView!

  var model: HYBTweetModel? {
    didSet {
      if model != nil {
        self.portraitImageView.loadImage(model!.portrait, holder: "holder");
        self.authorLabel.text = String(format: "%@：", model!.author);
        self.bodyLabel.text = model!.body;
        self.commentCountLabel.text = String(format: "%d", model!.commentCount);
        self.pubDateLabel.text = model!.pubDate;
        if model!.imgSmall.isEmpty {
          self.imgSmall.hidden = true;
        } else {
          self.imgSmall.loadImage(model!.imgSmall, holder: "tweetloading");
        }
      }
    }
  }
  
  class func height(model: HYBTweetModel) -> CGFloat {
    var h = 26;
    
    //h += model.body.size(UIFont(fontWithSize: 13), )
    return 0;
  }
}
