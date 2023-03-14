import UIKit

enum ViewModelActions {
    case save(Int)
    case delete(Int)
    case deleteAll
}

final class ViewModel {
    func action(_ actions: ViewModelActions) {
        switch actions {
        case .save(let data):
            save(data)
        case .delete(let data):
            delete(data)
        case .deleteAll:
            deleteAll()
        }
    }
    
    private func save(_ data: Int) {
        print("Save \(data)")
    }
    
    private func delete(_ data: Int) {
        print("Delete \(data)")
    }
    
    private func deleteAll() {
        print("Delete All Data")
    }
}

let viewModel = ViewModel()

viewModel.action(.save(1))
viewModel.action(.delete(1))
viewModel.action(.deleteAll)
