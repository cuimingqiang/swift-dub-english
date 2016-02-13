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
        tab.tintColor = ColorConstant.GREEN
    }
}