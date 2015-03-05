//
//  NSStringCommonExtension.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// String结构通用功能扩展
///
extension String {
  ///
  /// 获取自身md5加密后的字符串
  ///
  var md5 : String {
    let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
    let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen);
    
    CC_MD5(str!, strLen, result);
    
    var hash = NSMutableString();
    for i in 0 ..< digestLen {
      hash.appendFormat("%02x", result[i]);
    }
    result.destroy();
    
    return String(format: hash)
  }
  
  ///
  /// 计算文本的长宽
  ///
  /// font 字体
  ///
  /// maxWidth 限制长度
  ///
  /// return 返回文本的长和宽
  ///
  func size(font: UIFont, maxWidth: CGFloat) -> CGSize {
    var attributes = [NSFontAttributeName: font]
    var option = NSStringDrawingOptions.UsesLineFragmentOrigin
    var text: NSString = NSString(CString: self.cStringUsingEncoding(NSUTF8StringEncoding)!,
      encoding: NSUTF8StringEncoding)!
    let rect = text.boundingRectWithSize(CGSizeMake(maxWidth, 99999), options: option, attributes: attributes, context: nil)
    return rect.size;
  }
  
  //  func size(fontSize: CGFloat, maxWidth: CGFloat) -> CGSize {
  //    self.size(UIFont(fontSize), maxWidth);
  //  }
}
