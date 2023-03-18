import UIKit

protocol ListViewModelable {
    associatedtype T
    func fetch() -> [T]
}

struct IntListViewModel: ListViewModelable {
    var arr: [Int] = [1, 2, 3, 4, 5]
    func fetch() -> [Int] {
        return arr
    }
}

struct StringListViewModel: ListViewModelable {
    var arr: [String] = ["A", "B", "C", "D", "E"]
    func fetch() -> [String] {
        return arr
    }
}

final class ListViewController {
    typealias AnyListViewModelable = any ListViewModelable
    
    var viewModel: AnyListViewModelable
    
    init(listViewModelable: AnyListViewModelable) {
        self.viewModel = listViewModelable
    }
    
    func start() {
        let arr = viewModel.fetch()
        print(arr)
    }
    
    func changeViewModel(_ viewModel: AnyListViewModelable) {
        self.viewModel = viewModel
    }
}

let intListViewModel = IntListViewModel()
let stringListViewModel = StringListViewModel()

let intVC = ListViewController(listViewModelable: intListViewModel)
intVC.start()

let stringVC = ListViewController(listViewModelable: stringListViewModel)
stringVC.start()

let vc = ListViewController(listViewModelable: intListViewModel)
vc.start()

vc.changeViewModel(stringListViewModel)
vc.start()
