//
//  UserInfo.swift
//  dub
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class UserInfo {
    
}
extension UserInfo:JsonToObject{
    class func toObject(json: JSON?) -> UserInfo? {
        let info = UserInfo.init()
        return info
    }
}