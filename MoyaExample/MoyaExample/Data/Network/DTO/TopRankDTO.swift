//
//  TopRankDTO.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation

// MARK: - TopRankDTO
struct TopRankDTO: Decodable {
    let feed: Feed?
}

// MARK: - Feed
struct Feed: Decodable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright, country: String?
    let icon: String?
    let updated: String?
    let results: [TopRankAppDTO]?
}

// MARK: - Author
struct Author: Decodable {
    let name: String?
    let url: String?
}

// MARK: - Link
struct Link: Decodable {
    let linkSelf: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - TopRankAppDTO
struct TopRankAppDTO: Decodable {
    let id: String
    let name: String
    let artistName: String?
    let releaseDate: String?
    let kind: String?
    let artworkURL100: String?
    let genres: [String]?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artistName
        case releaseDate
        case kind
        case artworkURL100 = "artworkUrl100"
        case genres
        case url
    }
}

extension TopRankAppDTO {
    func toEntity() -> TopRankApp {
        return .init(id: Int(id),
                     name: name,
                     artworkURL100: artworkURL100)
    }
}
