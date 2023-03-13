import UIKit

enum ItemType: Hashable, CustomStringConvertible {
    case old, new
    
    var description: String {
        switch self {
        case .old: return "old"
        case .new: return "new"
        }
    }
}

struct Item: CustomStringConvertible {
    var name: String
    var type: ItemType
    
    var description: String {
        return name
    }
}

let items: [Item] = [Item(name: "ID1", type: .new),
                     Item(name: "ID2", type: .old),
                     Item(name: "ID3", type: .old),
                     Item(name: "ID4", type: .new),
                     Item(name: "ID5", type: .new)]

var dict1: [ItemType: [Item]] = [:]
for item in items {
    dict1[item.type, default: []].append(item)
}
print("dict1: \(dict1)")

//var dict2: [ItemType: [Item]] = Dictionary(grouping: items, by: { $0.type })
var dict2: [ItemType: [Item]] = Dictionary(grouping: items, by: \.type)
print("dict2: \(dict2)")
