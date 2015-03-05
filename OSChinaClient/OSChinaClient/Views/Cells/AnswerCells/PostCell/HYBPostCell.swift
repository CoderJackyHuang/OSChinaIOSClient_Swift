//
//  HYBPostCell.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/5.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 问答模块中的问答、分享、综合、职业、站务对应的表格单元
///
class HYBPostCell: HYBBaseCell {
  @IBOutlet weak var portraitImageView: HYBLoadingImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var pubLabel: UILabel!
  @IBOutlet weak var answerCountLabel: UILabel!
  
  var model: HYBPostModel? {
    didSet {
      if model != nil {
        self.titleLabel.text = model?.title;
        self.pubLabel.text = String(format: "%@ 发布于%@", model!.author, model!.pubDate);
        self.answerCountLabel.text = String(format: "%d", model!.answerCount);
        self.portraitImageView.loadImage(model!.portrait, holder: "holder");
      }
    }
  }
}
