//
//  API+User.swift
//  dub
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import RxSwift
extension API{
    class func login(mobile mobile:String, password:String) -> Observable<UserInfo>{
        let param = ["mobile":mobile,"password":password,"devicetoken":"----"]
        return request(url: "/user/login", method: .POST, param: param)
    }
}