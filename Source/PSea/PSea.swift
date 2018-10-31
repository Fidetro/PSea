//
//  PSea.swift
//  PSea
//
//  Created by Fidetro on 23/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire
public typealias SccuessCallBack = ((_ parseValue:Any?,_ data:Any)->())
public typealias ErrorCallBack = ((_ response:DataResponse<Any>,_ ret:String,_ message:String)->())
public typealias FailureCallBack = ((_ response:DataResponse<Any>,_ error:Error)->())

public protocol PSea: class {
    var successHandler : SccuessCallBack?{get set}
    var errorHandler : ErrorCallBack?{get set}
    var failureHandler : FailureCallBack?{get set}
    var requestInterval : TimeInterval {get set}
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
    
    func request(_ completionHandler: @escaping ((DataResponse<Any>) -> ()))
    func upload(multipartFormData: @escaping (MultipartFormData) -> Void) -> PSea
    func successParse(response: DataResponse<Any>)
    func errorParse(response: DataResponse<Any>)
    func failureParse(response:DataResponse<Any>,error: Error)
    
}

extension PSea {
    
    public func request(_ completionHandler: @escaping ((DataResponse<Any>) -> ())) {
        let url = baseURL()+requestURI()
        Alamofire.request(url, method: method(), parameters: parameters(), encoding: encoding(), headers: headers()).responseJSON(completionHandler: completionHandler)
    }
    
    @discardableResult
    public func success<T:Decodable>(_ type:T.Type?=nil,_ success:((_ response:T?,_ data:Any)->())?) -> PSea {
        self.successHandler = { (parse,data) in
            do{
                if let handler = success {
                    if let parseData = parse as? [String:Any] {
                        let data = try JSONSerialization.data(withJSONObject: parseData as Any, options: .prettyPrinted)
                        let model = try JSONDecoder().decode(T.self, from: data)
                        handler(model,data)
                    }else if let parseData = parse as? [Any] {
                        let data = try JSONSerialization.data(withJSONObject: parseData as Any, options: .prettyPrinted)
                        let model = try JSONDecoder().decode(T.self, from: data)
                        handler(model,data)
                    }else if let parseData = parse as? T {
                        handler(parseData,data)
                    }else{
                        handler(nil,data)
                    }
                }
            }catch{
                if let handler = success {
                    handler(nil,data)
                }
            }
        }
        return self
    }
    
    @discardableResult
    public func success(_ success:((_ response:Any?,_ data:Any)->())?) -> PSea {
        self.successHandler = { (parse,data) in
            if let handler = success {
                handler(parse,data)
            }
        }
        return self
    }
    
    @discardableResult
    public func error(_ error:ErrorCallBack?) -> PSea {
        self.errorHandler = error
        return self
    }
    
    @discardableResult
    public func failure(_ failure:FailureCallBack?) -> PSea {
        self.failureHandler = failure
        return self
    }
    
    @discardableResult
    public func request() -> PSea {
        
        guard PSeaQueue.share.set(object: self) else { return self }
        
        request {  (response) in
            switch response.result {
            case .success( _):
                self.successParse(response: response)
                self.errorParse(response: response)
            case .failure(let error):
                self.failureParse(response: response, error: error)
            }
        }
        return self
    }
    
    public func upload(multipartFormData: @escaping (MultipartFormData) -> Void) -> PSea {
        
        guard PSeaQueue.share.set(object: self) else { return self }
        
        let url = baseURL()+requestURI()
        Alamofire.upload(multipartFormData: multipartFormData, to: url, method: method(), headers: headers()) { (encodingResult) in
            switch encodingResult {
            case .success(let request, _, _):
                request.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success( _):
                        self.successParse(response: response)
                        self.errorParse(response: response)
                    case .failure(let error):
                        self.failureParse(response: response, error: error)
                    }
                })
                
            case .failure(let error):
                self.failureParse(response: DataResponse(request: nil, response: nil, data: nil, result: .failure(error)), error: error)
            }
        }
        return self
    }
}

