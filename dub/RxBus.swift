//
//  RxBus.swift
//  dub
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import RxSwift

final class RxBus {
    private static let eventBus = PublishSubject<Any>.init()
    internal class func obtainEvent<E>() -> Observable<E>{
        return eventBus.filter{ $0 is E}.map{ $0 as! E}
    }
    internal class func postEvent( o:AnyObject){
        eventBus.on(Event.Next(o))
    }
    
}