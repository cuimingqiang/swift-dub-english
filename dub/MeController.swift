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
import Kingfisher
class MeController:UIViewController{
    lazy var navigation = UINavigationBar.init()
    lazy var tableView = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.Grouped)
    
    var data :Array<Any> = []
    var section :[Int] = []
    override func viewDidLoad() {
        initNav()
        initData()
        initTable()
    }
    
    private func initData(){
        data.append(Item.init(image: "default_avatar", title: "个人信息"))
        section.append(1)
        data.append(Item.init(image: "", title: "新功能"))
        section.append(1)
        data.append(Item.init(image: "my_dub", title: "我的配音"))
        data.append(Item.init(image: "my_favor", title: "我的收藏"))
        data.append(Item.init(image: "my_photo", title: "我的相册"))
        section.append(3)
        data.append(Item.init(image: "my_chathistory", title: "通话记录"))
        section.append(1)
        data.append(Item.init(image: "my_nwordbook", title: "生词本"))
        data.append(Item.init(image: "my_fansub", title: "字幕组"))
        section.append(2)
        data.append(Item.init(image: "my_share", title: "告诉朋友"))
        section.append(1)
    }
}

extension MeController{
    func initNav(){
        let title = UINavigationItem.init(title: "我")
        navigation.pushNavigationItem(title, animated: false)
        self.view.addSubview(navigation)
        navigation.snp_makeConstraints{
            $0.height.equalTo(64)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view)
        }
    }
}
extension MeController{
    func initTable(){
        tableView.dataSource = self
        tableView.delegate = self
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
    }
}


extension MeController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section[section]
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var row = 0
        for var i = 0 ; i < indexPath.section ; i++ {
            row += section[i]
        }
        let item = data[indexPath.row + row]
        if indexPath.section == 0 {
            return initHeader(item as! Item)
        }
        return initCommonItem(item as! Item)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return section.count
    }
    func initHeader(item:Item) -> UITableViewCell{
        let cell = UITableViewCell.init()
        let photo = UIImageView.init()
        photo.layer.cornerRadius = 28
        photo.image = UIImage.init(named: item.image)
        cell.addSubview(photo)
        photo.snp_makeConstraints {
            $0.width.height.equalTo(55)
            $0.centerY.equalTo(cell)
            $0.left.equalTo(15)
        }
        let name = UILabel.init()
        name.text = item.title
        cell.addSubview(name)
        name.snp_makeConstraints {
            $0.left.equalTo(75)
            $0.centerY.equalTo(cell)
        }
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "common_more_arrow")
        cell.addSubview(arrow)
        arrow.snp_makeConstraints {
            $0.right.equalTo(cell)
            $0.centerY.equalTo(cell)
        }
        return cell
    }
    func initCommonItem(item:Item)-> UITableViewCell{
        let cell = UITableViewCell.init()
        let icon = UIImageView.init()
        icon.image = UIImage.init(named: item.image)
        cell.addSubview(icon)
        icon.snp_makeConstraints {
            $0.height.width.equalTo(25)
            $0.centerY.equalTo(cell)
            $0.left.equalTo(15)
        }
        let name = UILabel.init()
        name.text = item.title
        cell.addSubview(name)
        name.snp_makeConstraints {
            $0.left.equalTo(55)
            $0.centerY.equalTo(cell)
        }
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "common_more_arrow")
        cell.addSubview(arrow)
        arrow.snp_makeConstraints {
            $0.right.equalTo(cell)
            $0.centerY.equalTo(cell)
        }
        return cell
    }
}

extension MeController : UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0...1:
            return 85
        default:
            return 44
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
struct Item {
    var image : String
    var title : String
}