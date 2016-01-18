//
//  MainController.swift
//  dub
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import UIKit
class MainTabController: UITabBarController{
    
    @IBOutlet weak var tab: UITabBar!
    
    override func viewDidLoad() {
        tab.tintColor = UIColor.init(red: 0x2b/0xff, green: 0xc3/0xff, blue: 0x29/0xff, alpha: 1.0)
    }
}