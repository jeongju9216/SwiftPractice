//
//  MainViewModel.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import Foundation
import Combine

enum MainViewModelActions {
    case search(String)
    case updateText(String)
}

protocol MainViewModelInput {
    var text: String { get }
}

protocol MainViewModelOutput {
    var apps: [App] { get }
}

protocol MainViewModeling: MainViewModelInput, MainViewModelOutput { }

final class MainViewModel: MainViewModeling {
    @Published var text: String = "" //SearchBar 텍스트
    private var lastSearchText: String = "" //마지막 검색어
    
    @Published var apps: [App] = [] //검색 결과
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let searchAppUseCase: SearchAppUseCaseProtocol
    
    init(searchAppUseCase: SearchAppUseCaseProtocol) {
        self.searchAppUseCase = searchAppUseCase
        bind()
    }
    
    private func bind() {
        $text
            .debounce(for: 2.0, scheduler: RunLoop.main) //2초 후 자동 검색
            .sink { [weak self] query in
                guard let self = self else { return }

                //최신 검색어로 검색
                if !query.isEmpty && query != self.lastSearchText {
                    self.search(query: query)
                }
            }
            .store(in: &cancellables)
    }
}

extension MainViewModel {
    //MARK: - Action
    func action(_ actions: MainViewModelActions) {
        switch actions {
        case .search(let query):
            search(query: query)
        case .updateText(let text):
            updateText(text)
        }
    }
    
    //MARK: - Private Method
    private func search(query: String) {
        let appQuery = AppQuery(query: query)
        self.searchAppUseCase.execute(requestValue: .init(query: appQuery)) { [weak self] result in
            guard let self = self else { return }
            
            if let apps = try? result.get() {
                self.lastSearchText = query
                self.apps = apps
            }
        }
    }
    
    private func updateText(_ text: String) {
        self.text = text
    }
}
