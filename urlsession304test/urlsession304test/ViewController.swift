//
//  ViewController.swift
//  urlsession304test
//
//  Created by 유정주 on 2023/02/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
        
        Task {
            request()
            
            sleep(1)
            
            request()
        }
    }
    
    func request() {
        guard let url = URL(string: "https://is3-ssl.mzstatic.com/image/thumb/Purple116/v4/0a/5a/13/0a5a1385-6577-52b7-6460-66017b84da46/8ea08b3a-22de-43d2-b80c-0a87aea4b6af_iPad_01@2x.png/576x768bb.png") else {
            print("url error")
            return
        }

        // 2. URLRequest 객체 생성
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET" // POST, PUT, DELETE, HEAD, PATCH 가능
        urlRequest.cachePolicy = .useProtocolCachePolicy

        // 3. URLSessionDataTask 객체 생성
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            guard error == nil else {
                print("network error")
                return
            }

            let successsRange = 200..<300
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            let statusCode = httpResponse.statusCode

            if let etag = httpResponse.allHeaderFields["Etag"] as? String {
                print("etag: \(etag)")
            }
            
//            if successsRange.contains(statusCode) {
//
//            }
            
            print("statusCode: \(statusCode)")
            
            guard let resultData = data else {
                return
            }
                        
            print(resultData)
        }

        // URLSessionDataTask 객체를 이용하여 실행 or 취소
        dataTask.resume()
    }
}

