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
class GroupController:UIViewController{
    lazy var navigtion = UINavigationBar.init()
    override func viewDidLoad() {
        initNavi()
    }
}

extension GroupController{
    func initNavi(){
        let title = UINavigationItem.init(title: "小组")
        let right = UIBarButtonItem.init(title: "创建小组", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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