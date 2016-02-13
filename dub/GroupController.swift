//
//  MeController.swift
//  dub
//
//  Created by admin on 16/1/16.
//  Copyright © 2016年 admin. All rights reserved.
//
//改变字体大小
import Foundation
import UIKit
import SnapKit
import MJRefresh
class GroupController:UIViewController{
    lazy var navigtion = UINavigationBar.init()
    lazy var tableView = UITableView.init()
    lazy var segment = UISegmentedControl.init(items: ["查找小组","我的小组"])
    override func viewDidLoad() {
        initNavi()
        initTab()
//        initTable()
    }
}

extension GroupController{
    func initNavi(){
        let title = UINavigationItem.init(title: "小组")
        let right = UIBarButtonItem.init(title: "创建小组", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        right.tintColor = ColorConstant.GREEN
        right.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(10)], forState: UIControlState.Normal)
        title.setRightBarButtonItem(right, animated: false)
        navigtion.pushNavigationItem(title, animated: false)
        self.view.addSubview(navigtion)
        navigtion.snp_makeConstraints {
            $0.height.equalTo(64)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view)
        }
        
    }
}

extension GroupController{
    func initTab(){
        segment.tintColor = ColorConstant.GREEN
        segment.selectedSegmentIndex = 0
        self.view.addSubview(segment)
        segment.snp_makeConstraints {
            $0.height.equalTo(30)
            $0.left.equalTo(10)
            $0.centerX.equalTo(view)
            $0.top.equalTo(74)
        }
    }
}

extension GroupController{
    func initTable(){
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.sectionFooterHeight = 5
        tableView.sectionHeaderHeight = 5
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: "refresh")
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints {
            $0.top.equalTo(64)
            $0.width.equalTo(view)
            $0.bottom.equalTo(view)
        }
    }
    func refresh(){
        tableView.mj_header.endRefreshing()
    }
}