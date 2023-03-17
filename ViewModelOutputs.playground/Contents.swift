import UIKit

enum ViewModelActions {
    case save(Int)
    case delete(Int)
    case deleteAll
}

enum ViewModelOutputs {
    case isSuccess(Bool)
    case numberOfDeletedItems(Int)
    
    func value() -> Any {
        switch self {
        case .isSuccess(let isSuccess):
            return isSuccess
        case .numberOfDeletedItems(let number):
            return number
        }
    }
}

final class ViewModel {
    var array: [Int] = []
    func action(_ actions: ViewModelActions) -> ViewModelOutputs {
        switch actions {
        case .save(let data):
            return .isSuccess(save(data))
        case .delete(let data):
            return .isSuccess(delete(data))
        case .deleteAll:
            return .numberOfDeletedItems(deleteAll())
        }
    }
    
    private func save(_ data: Int) -> Bool {
        print("Save \(data)")
        array.append(data)
        return true
    }
    
    private func delete(_ data: Int) -> Bool {
        print("Delete \(data)")
        guard let index = array.firstIndex(of: data) else {
            return false
        }
        
        array.remove(at: index)
        return true
    }
    
    private func deleteAll() -> Int {
        print("Delete All Data")
        let count = array.count
        array = []
        return count
    }
}

let viewModel = ViewModel()

let isSaveSuccess = viewModel.action(.save(1)).value()
print(isSaveSuccess)

let isDeleteSuccess = viewModel.action(.delete(2)).value()
print(isDeleteSuccess)

let numberOfDeletedItems = viewModel.action(.deleteAll).value()
print(numberOfDeletedItems)
