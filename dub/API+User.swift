//
//  API+User.swift
//  dub
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
extension API{
    class func login(mobile mobile:String, password:String) -> Requestable<UserInfo>{
        let param = ["mobile":mobile,"password":password,"devicetoken":"----"]
        return Requestable.init(mothod:.POST, url: "/user/login", parameters: param)
    }
}