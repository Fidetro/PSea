//
//  TestRequest.swift
//  PSeaTests
//
//  Created by Fidetro on 2018/10/18.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire
class TestRequest: PSea {
    var successHandler: SccuessCallBack?
    
    var errorHandler: ErrorCallBack?
    
    var failureHandler: FailureCallBack?
    
    var requestInterval: TimeInterval = 2.0
    
    func method() -> HTTPMethod {
        return .post
    }
    
    func baseURL() -> String {
        return ""
    }
    
    func requestURI() -> String {
        return ""
    }
    
    func parameters() -> Parameters? {
        return nil
    }
    
    func headers() -> HTTPHeaders? {
        return nil
    }
    
    func encoding() -> ParameterEncoding {
        return URLEncoding.httpBody
    }
    
    func successParse(response: DataResponse<Any>) {
        
    }
    
    func errorParse(response: DataResponse<Any>) {
        
    }
    
    func failureParse(response: DataResponse<Any>, error: Error) {
        
    }
    

}
