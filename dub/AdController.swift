//
//  AdController.swift
//  dub
//
//  Created by admin on 16/1/16.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import UIKit

class Adcontroller:UIViewController{

    override func viewDidAppear(animated: Bool) {
        let login = storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginController
        presentViewController(login, animated: true, completion: nil)
    }
}