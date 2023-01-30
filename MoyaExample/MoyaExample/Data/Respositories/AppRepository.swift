//
//  AppRepository.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/29.
//

import Foundation
import Moya

final class AppRepository {
    private let provider = MoyaProvider<ItunesTargetType>()
}

extension AppRepository: AppRepositoryProtocol {
    func fetchAppsList(query: AppQuery, completion: @escaping (Result<[App], Error>) -> Void) {
        provider.request(.search(query: query.query)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecode = JSONDecoder()
                    jsonDecode.dateDecodingStrategy = .iso8601
                    
                    let decoded = try jsonDecode.decode(ItunesDTO.self, from: response.data)
                    
                    let appDTOes: [AppDTO] = decoded.results ?? []
                    let apps: [App] = appDTOes.map { $0.toEntity() }

                    completion(.success(apps))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
