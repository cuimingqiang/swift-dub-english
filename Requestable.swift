//
//  Request.swift
//  dub
//
//  Created by cuimingqiang on 16/2/15.
//  Copyright © 2016年 admin. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

public class Requestable<Element:NSObject> : ObservableType{
    public typealias E = Element

    var mothod : Alamofire.Method
    var url : URLStringConvertible
    var parameters : [String: AnyObject]?
    var encoding: ParameterEncoding = .JSON
    var headers: [String: String]?

 

    public func subscribe<O : ObserverType where O.E == E>(observer: O) -> Disposable {
        if(API.debug){
            print("<-- \(mothod) : \(url)\n\(parameters!)")
        }
        let request = Alamofire.request(self.mothod,url,parameters: self.parameters,encoding: self.encoding,headers: self.headers)
        return request.responseObject(E).subscribe(observer)
    }
    /**
     网络请求

     - parameter mothod:     请求方式
     - parameter url:        请求路径，不需要host
     - parameter parameters: 请求参数
     - parameter encoding:   参数编码类型
     - parameter headers:    请求头

     - returns: 对象
     */
    public init(mothod:Alamofire.Method,url:URLStringConvertible,parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        headers: [String: String]? = nil){
            self.mothod = mothod
            self.url = "\(API.server_url)\( url)"
            self.parameters = parameters
            self.encoding = encoding
            self.headers = headers
    }
}

extension Request{
    func err(msg:String = "数据格式错误") -> RequestError{
        return RequestError.init(msg: msg, status: -1)
    }

    func responseObject<T : NSObject>(classType:T.Type) -> Observable<T>{
        return Observable.create({ observer -> Disposable in
            self.responseJSON{
                let result = $0.result
                if let error = result.error where result.isFailure {
                    observer.onError(error)
                    return
                }
                if(API.debug){
                    print("--> POST : \(($0.request?.URLString)!) \n\(result.value)")
                }
                guard let json = result.value else{
                    observer.onError(self.err())
                    return
                }

                guard let rst = Result.mj_objectWithKeyValues(json) else{
                    observer.onError(self.err())
                    return
                }

                if(rst.status == 1){
                    guard let data = T.mj_objectWithKeyValues(rst.data) else{
                        observer.onError(self.err("数据解析出错"))
                        return
                    }
                    observer.onNext(data)
                    observer.onCompleted()
                }else{
                    return observer.onError(RequestError.init(msg: rst.msg, status: rst.status))
                }

            }
            return AnonymousDisposable{
                self.cancel()
            }
        })
    }
}

class Result : NSObject{
    var status = 0
    var msg = ""
    var data : AnyObject?
}
