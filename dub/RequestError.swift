//
//  RequestError.swift
//  dub
//
//  Created by cuimingqiang on 16/1/7.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

import Foundation
import RxCocoa
class RequestError: ErrorType {
    var msg:String?
    var status:Int!
    init(msg:String?,status:Int?){
        self.msg = msg
        self.status = status
    }
}