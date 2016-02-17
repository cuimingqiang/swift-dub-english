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
import RxSwift
import RxCocoa
class GroupController:UIViewController{
    lazy var navigtion = UINavigationBar.init()
    lazy var segment = UISegmentedControl.init(items: ["查找小组","我的小组"])
    lazy var myTableView = UITableView.init()
    lazy var container = UIScrollView.init()
    lazy var lookPart = LookGroupPart(frame: CGRectMake(0,0,0,0))

    override func viewDidLoad() {
        initNavi()
        initTab()
        initContainer()
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
        segment.addTarget(self, action: "select", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segment)
        segment.snp_makeConstraints {
            $0.height.equalTo(30)
            $0.left.equalTo(10)
            $0.centerX.equalTo(view)
            $0.top.equalTo(74)
        }

    }
 
    func select(){
        let rect = CGRectMake(CGFloat(segment.selectedSegmentIndex) * container.frame.size.width, 0,
            container.frame.size.width, container.frame.size.height)
        container.scrollRectToVisible(rect, animated: true)
    }
}

extension GroupController : UIScrollViewDelegate{
    func initContainer(){
        container.pagingEnabled = true
        container.delegate = self
        container.showsHorizontalScrollIndicator = false
        container.showsVerticalScrollIndicator = false
        container.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * 2, 553)
        self.view.addSubview(container)
        container.snp_makeConstraints {
            $0.top.equalTo(114)
            $0.width.equalTo(view)
            $0.bottom.equalTo(view)
        }
        container.addSubview(lookPart)
        lookPart.snp_makeConstraints {
            $0.width.height.top.equalTo(container)
        }
        initMyTableView(container)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(container.contentOffset.x * 2 / container.frame.width)
        segment.selectedSegmentIndex = page
    }
}

extension GroupController{
    /**
     <#Description#>
     
     - parameter parentView: <#parentView description#>
     
     - returns: <#return value description#>
     */
    func initMyTableView(parentView : UIView){
        myTableView.bounces = true
        myTableView.alwaysBounceVertical = true
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        myTableView.sectionFooterHeight = 5
        myTableView.sectionHeaderHeight = 5
        myTableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: "refresh_my")
        parentView.addSubview(myTableView)
        myTableView.snp_makeConstraints {
            $0.width.height.top.equalTo(parentView)
            $0.left.equalTo(UIScreen.mainScreen().bounds.width)
        }

    }
    func refresh_my(){
        myTableView.mj_header.endRefreshing()
    }
}