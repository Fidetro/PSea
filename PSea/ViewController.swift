//
//  ViewController.swift
//  PSea
//
//  Created by Fidetro on 23/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = TestRequest()
        let o = Observable.just(test)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

