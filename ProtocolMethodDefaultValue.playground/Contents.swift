import UIKit

protocol DependencyProtocol {
    
    var useCase: UseCaseProtocol { get }
}

struct Dependency: DependencyProtocol {
    
    let useCase: UseCaseProtocol
}

protocol UseCaseProtocol {
    
    func execute(value: Int) async
}

extension UseCaseProtocol {
    
    func execute(value: Int = 1) async {
        await execute(value: value)
    }
}

struct UseCase: UseCaseProtocol {
    
    func execute(value: Int) async {
        print("execute: \(value)")
    }
}

let useCase: UseCaseProtocol = UseCase()
let dependency: DependencyProtocol = Dependency(useCase: useCase)

Task {
    await dependency.useCase.execute()
}
