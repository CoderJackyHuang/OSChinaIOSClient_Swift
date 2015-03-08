//
//  HYBSoftwareController.swift
//  OSChinaClient
//
//  Created by huangyibiao on 15/3/8.
//  Copyright (c) 2015年 huangyibiao free edu. All rights reserved.
//

import UIKit

///
/// 更多模块中的软件模块入口
///
class HYBSoftwareController: HYBParentTableController {
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.titleView(["分类", "推荐", "最新", "热门", "国产"], selectedIndex: 0);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight - kStatusBarHeight);
    
    self.downloadData();
  }
  
  override func onSelectedTitleControl(sender: UISegmentedControl) {
    self.downloadData();
  }
  
  func downloadData() {
    var searchTag = "";
    var params = [String: AnyObject]?()
    
    switch (self.titleControl!.selectedSegmentIndex) {
    case 1:
      searchTag = "recommend"
      break
    case 2:
      searchTag = "time"
      break
    case 3:
      searchTag = "view"
      break
    case 4:
      searchTag = "list_cn"
      break
    default:
      break
    }
  
    if self.titleControl!.selectedSegmentIndex != 0 {
      params = ["searchTag" : searchTag, "pageSize" : "20", "pageIndex" : "0"]
    } else {
      params = nil
    }
      self.currentRequest = HYBBaseRequest.softwareList(kApiSoftwareList,
      params:params, success: { (modelList) -> () in
        self.datasource.removeAllObjects();
        self.datasource.addObjectsFromArray(modelList!);
        self.tableView.reloadData();
    }, fail: { (error) -> Void in
      self.showNetError(error);
    });
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell;
    
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: kCellIdentifier)
      cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
    }
    
    if indexPath.row < self.datasource.count {
      let model = self.datasource.objectAtIndex(indexPath.row) as? HYBSoftwareModel;
      cell?.textLabel?.text = model?.name;
    }
    
    return cell!;
  }
}
