//
//  API.swift
//  dub
//
//  Created by cuimingqiang on 15/12/23.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyJSON

enum HTTPMethod{
    case POST
    case GET
}
extension HTTPMethod{
    internal var string :String{
        switch(self){
        case .POST:
            return "POST"
        case .GET:
            return "GET"
        }
    }
}
class API{
    static let server_url = "https://test2.qupeiyin.net"
    
    class func request<O:JsonToObject where O.E == O>(url path:String,method:HTTPMethod,param:Dictionary<String,String>?)->Observable<Array<O>>{
        return try! request(url: path, method: method, param: param).flatMap({ (data) -> Observable<Array<O>> in
            return flatmap(data)
        })
        
    }
    class func request<O: JsonToObject where O.E == O>(url path:String,method:HTTPMethod,param:Dictionary<String,String>?)->Observable<O>{
        return try! request(url: path, method: method, param: param).flatMap({ (data) -> Observable<O> in
            return flatmap(data)
        })
    }
    class func request(url path:String,method:HTTPMethod,param:Dictionary<String,String>?) throws -> Observable<NSData> {
        if path.isEmpty{
            throw RequestError(msg: "请求地址为空", status: -100)
        }
        let url = NSURL(string: server_url+path)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method.string
        var body = ""
        if let params = param{
            for (key,value) in params{
                body += (key + "=\(value)&")
            }
        }
        if body.hasSuffix("&"){
            body = body.substringToIndex(body.endIndex.advancedBy(-1))
        }
        print("--> HTTP ",method.string,":",body)
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        return NSURLSession.sharedSession().rx_data(request)
    }
    
    class func flatmap<O:JsonToObject where O.E == O>(data:NSData)->Observable<Array<O>>{
        return flatmap(data, deal: { (d) -> Array<O> in
            var res:Array<O> = []
            for o in d{
                res.append(O.toObject(o.1)!)
            }
            return res
        })
    }
    
    class func flatmap<O: JsonToObject where O.E == O>(data:NSData)->Observable<O>{
        return flatmap(data, deal: { (d) -> O in
            O.toObject(d)!
        })
    }
    
    class func flatmap<O>(data:NSData,deal:(d:JSON)->O)->Observable<O>{
        let json = JSON.init(data: data, options: NSJSONReadingOptions.AllowFragments, error: NSErrorPointer.init())
        print("<-- HTTP Result:",json)
        let status = json.dictionaryValue["status"]?.int
        let msg = json.dictionaryValue["msg"]?.string
        return Observable.create({ (observer:AnyObserver<O>) -> Disposable in
            if(status == 1){
                let d = json.dictionaryValue["data"]
                observer.on(Event.Next(deal(d: d!)))
                observer.onCompleted()
            }else{
                observer.onError(RequestError.init(msg: msg,status: status))
            }
            return AnonymousDisposable(){}
        })
    }
    
}
