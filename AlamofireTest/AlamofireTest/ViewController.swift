//
//  ViewController.swift
//  AlamofireTest
//
//  Created by 유정주 on 2022/11/06.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        AF.request("https://tldr161718.site/version")
            .response { response in
            debugPrint(response)
        }
    }


}

