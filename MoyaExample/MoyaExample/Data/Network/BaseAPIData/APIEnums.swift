//
//  Country.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation

enum Country: String {
    case KR = "KR"
    case EN = "EN"
}

enum AppType: String, Decodable {
    case software = "sotfware"
}

enum Currency: String, Decodable {
    case krw = "KRW"
}
