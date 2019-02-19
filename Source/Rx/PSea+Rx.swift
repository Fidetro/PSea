//
//  PSea+Rx.swift
//  PSea
//
//  Created by Fidetro on 2018/10/31.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import PSea
public enum Result<T> {
    case success(T?,_ parseValue:Any?,_ data:Any)
    case error(_ response:DataResponse<Any>,_ code:Int,_ message:String)
    case failure(_ response:DataResponse<Any>,_ error:Error)
}
extension PSea: ReactiveCompatible {}
public extension Reactive where Base: PSea {
    
    public func request<T:Decodable>(map type:T.Type?=nil) -> Observable<Result<T>> {
        
        guard let type = type else {
            
            return Observable.create({ [weak base] (observer) -> Disposable in
                base?.request()
                    .success({ (parseValue, data) in
                    observer.onNext(.success(nil,parseValue,data))
                })
                    .error { (response, code, message) in
                    observer.onNext(.error(response,code,message))
                    }
                    .failure { (response, error) in
                        observer.onNext(.failure(response,error))
                }
                
                return Disposables.create {}
            })
        }
        
        return Observable.create({ [weak base] (observer) -> Disposable in
            base?.request().success(type) { (parseData, data) in
                observer.onNext(.success(parseData,nil,data))
                }
                .error { (response, code, message) in
                    observer.onNext(.error(response,code,message))
                }
                .failure { (response, error) in
                    observer.onNext(.failure(response,error))
            }
            
            return Disposables.create {}
        })
    }
    
    public func upload<T:Decodable>(multipartFormData: @escaping (MultipartFormData) -> Void, map type:T.Type?=nil) -> Observable<Result<T>> {
        
        guard let type = type else {
            
            return Observable.create({ [weak base] (observer) -> Disposable in
                
                base?.upload(multipartFormData: multipartFormData)
                    .success({ (parseValue, data) in
                    observer.onNext(.success(nil,parseValue,data))
                })
                    .error { (response, code, message) in
                    observer.onNext(.error(response,code,message))
                    }
                    .failure { (response, error) in
                        observer.onNext(.failure(response,error))
                }
                
                return Disposables.create {}
            })
        }
        
        return Observable.create({ [weak base] (observer) -> Disposable in
            
            base?.upload(multipartFormData: multipartFormData)
                .success(type) { (parseData, data) in
                observer.onNext(.success(parseData,nil,data))
                }
                .error { (response, code, message) in
                    observer.onNext(.error(response,code,message))
                }
                .failure { (response, error) in
                    observer.onNext(.failure(response,error))
            }
            
            return Disposables.create {}
        })
    }
    
}
