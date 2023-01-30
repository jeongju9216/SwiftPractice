//
//  App.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation

struct App {
    let id: Int?
    let name: String? //앱 이름
    let summary: String? //앱 간단 소개
    let artworkURL60, artworkURL100, artworkURL512: String? //앱 아이콘 URL
    
    let screenshotURLs: [String]? //앱 미리보기 스크린샷 URL
    let averageUserRating: Double? //앱 평점
    let userRatingCount: Int? //평가 개수
    let contentAdvisoryRating: String? //연령 등급
    let sellerName: String? //판매자 이름
    let releaseNotes: String? //릴리즈 노트
    let version: String? //앱버전
    let genres: [String]? //장르 리스트
    let supportedDevices: [String]? //호환 기기 리스트
    let minimumOSVersion: String? //최소 지원 버전
    let languageCodesISO2A: [String]? //지원 언어 리스트
    let fileSizeBytes: String? //앱크기(byte)
    
    //추가 구현 내용 데이터
    let advisories: [String]? //권고 사항 리스트(["무제한 웹 액세스"])
    let price: Int? //앱 가격
    let formattedPrice: String? //앱 가격 표시("무료", "W4,400"...)
    let kind: String? //앱 종류("software")
    let currentVersionReleaseDate: Date? //현재 버전 릴리즈 날짜
    let releaseDate: Date? //처음 릴리즈 날짜
    let description: String? //앱 설명
}

extension App {
    enum ArtworkSize {
        case small, medium, big
    }
    
    func artwork(_ size: ArtworkSize) -> String? {
        switch size {
        case .small:
            return artworkURL60
        case .medium:
            return artworkURL100
        case .big:
            return artworkURL512
        }
    }
}
