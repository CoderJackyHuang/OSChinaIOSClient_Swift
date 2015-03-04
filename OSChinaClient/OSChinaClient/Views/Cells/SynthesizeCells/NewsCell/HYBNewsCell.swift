//
//  HYBNewsCell.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 综合模块 资讯单元
///
class HYBNewsCell: HYBBaseCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib();
  }
  
  var model: HYBBaseModel? {
    didSet {
      if let m = model as? HYBNewsModel {
      self.titleLabel.text = m.title;
        self.bodyLabel.text = String(format: "%@ 发布于 %@ (%d评)", m.author, m.pubDate, m.commentCount);
      }
      
      if let m = model as? HYBBlogModel {
        self.titleLabel.text = m.title;
        self.bodyLabel.text = String(format: "%@ %@ %@ (%d评)",
          m.authorname,
          m.documentType == 1 ? "原创" : "转载",
          m.pubDate,
          m.commentCount);
      }
    }
  }
  
  required  init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
  }
}
