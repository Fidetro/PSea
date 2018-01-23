//
//  PSea.swift
//  PSea
//
//  Created by Fidetro on 23/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire

public typealias SccuessCallBack = ((_ response:DataResponse<Any>,_ data:Any)->())
public typealias ErrorCallBack = ((_ response:DataResponse<Any>,_ code:Int,_ message:String)->())
public typealias FailureCallBack = ((_ response:DataResponse<Any>,_ request:URLRequest?,_ error:Error?)->())

public protocol PSea: class {
    var successHandler : SccuessCallBack?{get set}
    var errorHandler : ErrorCallBack?{get set}
    var failureHandler : FailureCallBack?{get set}
    /// 请求方式
    func method() -> HTTPMethod
    /// 设置域名
    func baseURL() -> String
    /// 请求路由
    func requestURI() -> String
    /// 请求参数
    func parameters() -> Parameters?
    /// 请求头
    func headers() -> HTTPHeaders?
    /// 参数编码
    func encoding() -> ParameterEncoding
    
    func complete(_ completionHandler: @escaping ((DataResponse<Any>) -> ()))
    func successParse(response:DataResponse<Any>)
    func errorParse(response:DataResponse<Any>)
    func failureParse(response:DataResponse<Any>)
    
}

extension PSea {
    
    public func complete(_ completionHandler: @escaping ((DataResponse<Any>) -> ())) {
        let url = baseURL()+requestURI()
        Alamofire.request(url, method: method(), parameters: parameters(), encoding: encoding(), headers: headers()).responseJSON(completionHandler: completionHandler)
    }
    @discardableResult public func success(_ success:SccuessCallBack?) -> PSea {
        
        self.successHandler = success
        return self
    }
    
    @discardableResult public func error(_ error:ErrorCallBack?) -> PSea {
        self.errorHandler = error
        return self
    }
    
    @discardableResult public func failure(_ failure:FailureCallBack?) -> PSea {
        
        self.failureHandler = failure
        return self
    }
    @discardableResult public func request() -> PSea {
        complete {  (response) in
            self.successParse(response: response)
            self.errorParse(response: response)
            self.failureParse(response: response)
        }
        return self
    }
}

