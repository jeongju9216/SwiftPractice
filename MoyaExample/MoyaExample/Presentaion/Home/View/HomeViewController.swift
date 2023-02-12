//
//  HomeViewController.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/29.
//

import UIKit
import Moya

final class HomeViewController: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HomeViewController")
        
        testFree()
        testPaid()
    }
    
    //MARK: - Methods
    private func testFree() {
        let provider = MoyaProvider<TopRankTargetType>()
        provider.request(.free()) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(TopRankDTO.self, from: response.data)
                    
                    let topRankAppDTOes: [TopRankAppDTO] = decoded.feed?.results ?? []
                    let topRankApps: [TopRankApp] = topRankAppDTOes.map { $0.toEntity() }

                    print("==== Free Result ====")
                    var topRankAppNames: String = ""
                    for topRankApp in topRankApps {
                        topRankAppNames += "\(topRankApp.name ?? "")\n"
                    }
                    print(topRankAppNames)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func testPaid() {
        let provider = MoyaProvider<TopRankTargetType>()
        provider.request(.paid()) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(TopRankDTO.self, from: response.data)
                    
                    let topRankAppDTOes: [TopRankAppDTO] = decoded.feed?.results ?? []
                    let topRankApps: [TopRankApp] = topRankAppDTOes.map { $0.toEntity() }

                    print("==== Paid Result ====")
                    var topRankAppNames: String = ""
                    for topRankApp in topRankApps {
                        topRankAppNames += "\(topRankApp.name ?? "")\n"
                    }
                    print(topRankAppNames)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
