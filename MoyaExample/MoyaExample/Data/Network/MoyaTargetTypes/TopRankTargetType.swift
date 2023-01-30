//
//  TopRankAPI.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation
import Moya

enum TopRankTargetType {
    case free(count: Int = 5, country: Country = .KR)
    case paid(count: Int = 10, country: Country = .KR)
}

extension TopRankTargetType: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIBaseURL.topRankBaseURL) else {
            fatalError()
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .free(let count, let country):
            return "\(country)/apps/top-free/\(count)/apps.json"
        case .paid(let count, let country):
            return "\(country)/apps/top-paid/\(count)/apps.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .free(_, _), .paid(_, _):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .free(_, _), .paid(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
}
