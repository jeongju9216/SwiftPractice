//
//  SearchAppUseCase.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/29.
//

import Foundation

protocol SearchAppUseCaseProtocol {
    func execute(requestValue: SearchAppUseCaseRequestValue,
                 completion: @escaping (Result<[App], Error>) -> Void)
}

final class SearchAppUseCase: SearchAppUseCaseProtocol {
    private let appRepository: AppRepositoryProtocol

    init(appRepository: AppRepositoryProtocol) {
        self.appRepository = appRepository
    }
    
    func execute(requestValue: SearchAppUseCaseRequestValue, completion: @escaping (Result<[App], Error>) -> Void) {
        appRepository.fetchAppsList(query: requestValue.query) { result in
            completion(result)
        }
    }
}

struct SearchAppUseCaseRequestValue {
    let query: AppQuery
}
