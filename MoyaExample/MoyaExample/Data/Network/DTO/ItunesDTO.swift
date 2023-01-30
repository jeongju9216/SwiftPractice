//
//  AppDTO.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation

// MARK: - ItunesDTO
struct ItunesDTO: Decodable {
    let resultCount: Int?
    let results: [AppDTO]?
}

// MARK: - AppDTO
struct AppDTO: Decodable {
    let trackID: Int?
    let trackName: String?
    let isGameCenterEnabled: Bool?
    let supportedDevices: [String]?
    let screenshotUrls: [String]?
    let ipadScreenshotUrls, appletvScreenshotUrls: [String]?
    let artworkUrl60, artworkUrl512, artworkUrl100: String?
    let artistViewURL: String?
    let features, advisories: [String]?
    let kind, currency, releaseNotes: String?
    let artistID: Int?
    let artistName: String?
    let genres: [String]?
    let price: Int?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let genreIDS: [String]?
    let releaseDate: Date?
    let description, sellerName: String?
    let currentVersionReleaseDate: Date?
    let bundleID: String?
    let minimumOSVersion, trackCensoredName: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes, formattedPrice, contentAdvisoryRating: String?
    let averageUserRatingForCurrentVersion: Double?
    let userRatingCountForCurrentVersion: Int?
    let averageUserRating: Double?
    let trackViewURL: String?
    let trackContentRating, version, wrapperType, primaryGenreName: String?
    let primaryGenreID, userRatingCount: Int?

    enum CodingKeys: String, CodingKey {
        case isGameCenterEnabled, supportedDevices, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case features, advisories, kind, currency, releaseNotes
        case artistID = "artistId"
        case artistName, genres, price, isVppDeviceBasedLicensingEnabled
        case genreIDS = "genreIds"
        case releaseDate, description, sellerName, currentVersionReleaseDate
        case bundleID = "bundleId"
        case trackID = "trackId"
        case trackName
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes, formattedPrice, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating, version, wrapperType, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case userRatingCount
    }
}

extension AppDTO {
    func toEntity() -> App {
        return .init(id: trackID,
                     name: trackName,
                     summary: trackCensoredName,
                     artworkURL60: artworkUrl60,
                     artworkURL100: artworkUrl100,
                     artworkURL512: artworkUrl512,
                     screenshotURLs: screenshotUrls,
                     averageUserRating: averageUserRating,
                     userRatingCount: userRatingCount,
                     contentAdvisoryRating: contentAdvisoryRating,
                     sellerName: sellerName,
                     releaseNotes: releaseNotes,
                     version: version,
                     genres: genres,
                     supportedDevices: supportedDevices,
                     minimumOSVersion: minimumOSVersion,
                     languageCodesISO2A: languageCodesISO2A,
                     fileSizeBytes: fileSizeBytes,
                     advisories: advisories,
                     price: price,
                     formattedPrice: formattedPrice,
                     kind: kind,
                     currentVersionReleaseDate: currentVersionReleaseDate,
                     releaseDate: releaseDate,
                     description: description)
    }
}
