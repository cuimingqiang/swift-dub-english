//
//  MeController.swift
//  dub
//
//  Created by admin on 16/1/16.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class DubController : UIViewController{
    lazy var navigation = UINavigationBar.init()
    lazy var tableView = UITableView.init()
    lazy var refresh = UIRefreshControl.init()
    override func viewDidLoad() {
        initNav()
        initTableView()
    }
}
extension DubController{
    func initNav(){
        let bar = UINavigationItem.init()
        bar.setRightBarButtonItem(UIBarButtonItem.init(image: UIImage.init(named: "home_btn_search"),
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil), animated: false)
        let left = UIBarButtonItem.init(title: "英语趣配音",
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil)
        left.tintColor = UIColor.grayColor()
        left.enabled = false
        bar.setLeftBarButtonItem(left, animated: false)
        navigation.pushNavigationItem(bar, animated: false)
        view.addSubview(navigation)
        navigation.snp_makeConstraints{
            $0.height.equalTo(64)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view)
        }
    }
}

extension DubController{
    func initTableView(){
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0)
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0)
        tableView.sectionFooterHeight = 5
        tableView.sectionHeaderHeight = 5
        view.addSubview(tableView)
        tableView.snp_makeConstraints {
            $0.top.equalTo(64)
            $0.width.equalTo(view)
            $0.bottom.equalTo(view)
        }
        addRefresh()
    }
    func addRefresh(){
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        tableView.addSubview(refresh)
//        refresh.snp_makeConstraints {
//            $0.top.equalTo(64)
//            $0.width.equalTo(view)
//        }

    }
    func refreshData(){
        refresh.endRefreshing()
    }
}
//extension DubController : UITableViewDataSource,UITableViewDelegate{
//
//}