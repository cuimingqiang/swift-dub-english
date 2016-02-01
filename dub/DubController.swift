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
import SDCycleScrollView
class DubController : UIViewController{
    lazy var navigation = UINavigationBar.init()
    lazy var tableView = UITableView.init()
    lazy var refresh = UIRefreshControl.init()
    lazy var section : [Int] = [1,9]
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
//        tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0)
//        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0)
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
//        refresh.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        tableView.addSubview(refresh)
//        refresh.snp_makeConstraints {
//            $0.top.equalTo(view).offset(85)
//            $0.width.equalTo(view)
//           
//        }

    }
    func refreshData(){
        refresh.endRefreshing()
    }
}
extension DubController : UITableViewDataSource,UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section[section]
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : AnyObject
        switch indexPath.section{
        case 0:
            cell = createBanner()
        default:
            cell = UITableViewCell.init()
        }
        return cell as! UITableViewCell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 212
        default:
            return 44
        }
    }
    func createBanner() -> UITableViewCell{
        let cell = UITableViewCell.init()
        
        let bannerView = SDCycleScrollView.init(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, 212))
        bannerView.localizationImageNamesGroup = ["img_activity_head","img_activity_head","img_activity_head"]
        bannerView.titlesGroup = ["我啦是大事","我啦是大事","我啦是大事"]
       
        view.addSubview(bannerView)
        return cell
    }
}



