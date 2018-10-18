//
//  PSeaQueue.swift
//  PSea
//
//  Created by Fidetro on 2018/10/18.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire
public class PSeaQueue: NSObject {
    typealias T = PSea
    static let share = PSeaQueue()
    let lock = NSLock()
    var queue = [String:T]()
    
    func set(object:T) -> Bool {
        lock.lock()
        let mirror = Mirror.init(reflecting: object)
        let key = "\(mirror.subjectType)"
        if object.requestInterval == 0 {
            lock.unlock()
            return true
        }
        if let _ = queue[key] {
            lock.unlock()
            return false
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + object.requestInterval, execute: {
            self.queue.removeValue(forKey: key)
        })
        queue[key] = object
        lock.unlock()
        return true
    }
    
    
}
