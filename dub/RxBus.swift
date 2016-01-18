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
    private static let subject = PublishSubject<Any>.init()
    
    internal static func obtainEvent<E>() -> Observable<E>{
        return subject.filter{ $0 is E}
            .map{ $0 as! E}
    }
    
    internal static func postEvent( o:AnyObject){
        subject.on(Event.Next(o))
    }
}