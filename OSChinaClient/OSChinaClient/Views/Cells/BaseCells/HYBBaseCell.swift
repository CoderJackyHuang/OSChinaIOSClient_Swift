//
//  HYBBaseCell.swift
//  OSChinaClient
//
//  Created by 黄仪标 on 15/3/4.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 所有的单元都要直接或者间接继承于此类
///
class HYBBaseCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  required  init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
  }
}
