import UIKit

protocol Itemable {
    var priority: Int { get set }
}

enum ItemType {
    case custom(compareType: ((Itemable, Itemable) -> Bool))
}

func compared(type: ItemType) {
    let item1: Item = .init(priority: 1)
    let item2: Item = .init(priority: 2)
    let item3: Item = .init(priority: 3)
    let item4: Item = .init(priority: 4)
    let item5: Item = .init(priority: 5)
    let item6: Item = .init(priority: 6)

    var items: [Itemable] = [item1, item2, item3, item5, item6]
    
    var index: Int = 0
    
    switch type {
    case .custom(let compareRule):
        for item in items {
            if compareRule(item4, item) {
                items.insert(item4, at: index)
                break
            }
            index += 1
        }
    }
    
    print(items)
}

struct Item: Itemable {
    var priority: Int
}


let sortedRule: ItemType = .custom(compareType: { item1, item2 in
    return item1.priority < item2.priority
})

compared(type: sortedRule)
