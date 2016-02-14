//
//  LookGroupController.swift
//  dub
//
//  Created by admin on 16/2/14.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
class LookGroupPart : UIView, UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate{
    private lazy var lookTableView = UITableView.init()
    private lazy var dataSource = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        lookTableView.delegate = self
        lookTableView.dataSource = self
        lookTableView.bounces = true
        lookTableView.alwaysBounceVertical = true
        lookTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        lookTableView.sectionFooterHeight = 5
        lookTableView.sectionHeaderHeight = 5
        lookTableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: "refresh")
        self.addSubview(lookTableView)
        lookTableView.snp_makeConstraints {
            $0.width.height.top.equalTo(self)
        }
    }
    func refresh(){
        lookTableView.mj_header.endRefreshing()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        switch indexPath.section{
        case 0:
            cell = UITableViewCell.init()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let search = UISearchBar.init()
            search.backgroundColor = UIColor.blackColor()
            search.placeholder = "搜索小组号或小组名"
            search.delegate = self
            cell.addSubview(search)
            search.snp_makeConstraints{
                $0.width.height.equalTo(cell)
            }
        case 1:
            cell = UITableViewCell.init()
        default:
            cell = UITableViewCell.init()
        }
        return cell
    }
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        return false
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 40
        case 1:
            return 44
        default:
            return 44
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0...1:
            return 1
        default:
            return dataSource.count
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
}