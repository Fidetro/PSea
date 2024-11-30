//
//  PSea.swift
//  PSea
//
//  Created by Fidetro on 23/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire
public typealias ProgressHandler = @Sendable (_ progress: Progress) -> Void
public protocol PSeaType: AnyObject {

    
    init()
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

    func requestInterval() -> TimeInterval
}

extension PSeaType {
    
    public func requestInterval() -> TimeInterval {
        return 0.0
    }
    
}

public enum PSeaError: Error {
    case failure(_ error: Error)
}

open class PSea : PSeaType {

    required public init() { }
    
    var request: DataRequest?
    
    open func method() -> HTTPMethod {
        return .get
    }
    
    open func baseURL() -> String {
        return ""
    }
    
    open func requestURI() -> String {
        return ""
    }
    
    open func parameters() -> Parameters? {
        return nil
    }
    
    open func headers() -> HTTPHeaders? {
        return nil
    }
    
    open func requestInterval() -> TimeInterval {
        return 0.0
    }
    
    open func encoding() -> ParameterEncoding {
        return URLEncoding(destination: .httpBody)
    }
    
    open func cancel() {
        request?.cancel()
    }
    
    @discardableResult open func request<T: Decodable>(_ t: T.Type,completionHandler: @escaping (Result<(T,Data), Error>) -> Void) -> PSea {
        guard PSeaQueue.share.set(object: self) else { return self }
        let url = baseURL()+requestURI()
        self.request = AF.request(url, method: method(), parameters: parameters(), encoding: encoding(), headers: headers()).responseData { response in
            switch response.result {
            case .success(let data) :
                do {
                    print(url)
                    print(String(data: data, encoding: .utf8) ?? "")
                    let model = try JSONDecoder().decode(t, from: data)
                    completionHandler(.success((model, data)))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error) :
                print(url)                
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }
        return self
    }
    
    @discardableResult open func upload<T: Decodable>(_ t: T.Type,multipartFormData: @escaping (MultipartFormData) -> Void, progressHandler: ProgressHandler?, completionHandler: @escaping (Result<T, PSeaError>) -> Void) -> PSea {
        
        guard PSeaQueue.share.set(object: self) else { return self }
        let url = baseURL()+requestURI()
        AF.upload(multipartFormData: multipartFormData, to: url, method: method(), headers: headers()) .uploadProgress { progress in
            progressHandler?(progress)
        }.response { response in
            switch response.result {
            case .success(let data) :
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(t, from: data)
                        completionHandler(.success(model))
                    } catch {
                        completionHandler(.failure(.failure(error)))
                    }
                }
            case .failure(let error) :
                completionHandler(.failure(.failure(error)))
            }
        }
        return self
    }

    

       
}
