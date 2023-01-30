//
//  SwinjectContainer.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/29.
//

import Foundation
import Swinject
import SwinjectStoryboard

final class SwinjectContainer {
    var container: Container = Container()
    
    init() {
        registerMainSceneDependencies()
    }
    
    func registerMainSceneDependencies() {        
        self.container.register(AppRepositoryProtocol.self) { _ in
            AppRepository()
        }
        
        self.container.register(SearchAppUseCaseProtocol.self) { r in
            SearchAppUseCase(appRepository: r.resolve(AppRepositoryProtocol.self)!)
        }
        
        self.container.register(MainViewModeling.self) { r in
            MainViewModel(searchAppUseCase: r.resolve(SearchAppUseCaseProtocol.self)!)
        }
        
        self.container.storyboardInitCompleted(MainViewController.self) { r, c in
            c.viewModel = r.resolve(MainViewModeling.self) as? MainViewModel
        }
    }
}
