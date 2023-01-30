//
//  NetworkService.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation
import Moya

enum ItunesTargetType {
    case search(query: String, country: Country = .KR, entity: AppType = .software)
    case lookup(id: Int, country: Country = .KR, entity: AppType = .software)
}

enum ItunesAPIName: String {
    case search = "search"
    case lookup = "lookup"
}

extension ItunesTargetType: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIBaseURL.itunesBaseURL) else {
            fatalError()
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return "\(ItunesAPIName.search)"
        case .lookup:
            return "\(ItunesAPIName.lookup)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search, .lookup:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let query, let country, let entity):
            return .requestParameters(parameters: ["term": query, "country": country, "entity": entity], encoding: URLEncoding.queryString)
        case .lookup(let id, let country, let entity):
            return .requestParameters(parameters: ["id": id, "country": country, "entity": entity], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return .none
    }
}
