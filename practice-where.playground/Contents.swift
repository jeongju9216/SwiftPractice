import Foundation

// ----- for문 -----
for i in 0..<100 {
    if i % 5 == 0 {
        print(i)
    }
}

for i in 0..<100 where i % 5 == 0{
    print(i)
}

// ----- Generic -----
func isEqual<T: Equatable>(_ a: T, _ b: T) -> Bool {
    return a == b
}

func isEqualWithWhere<T>(_ a: T, _ b: T) -> Bool where T: Equatable {
    return a == b
}

// ----- Protocol -----
protocol Itemable {
    associatedtype Item
    var value: Item { get set }
    func equal(_ a: Item) -> Bool
}

extension Itemable where Item: Equatable {
    func equal(_ a: Item) -> Bool {
        return self.value == a
    }
}

class Item: Itemable {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

var items: [Item] = [Item(value: 1), Item(value: 2), Item(value: 3)]

print(items[0].equal(1)) //true

// ----- Enum -----
let grade = 89
switch grade {
    case 0..<60:
        print("F")
    case 60..<70:
        print("D")
    case 70..<80:
        print("C")
    case 80..<90:
        print("B")
    case 90...100 where grade % 5 == 0:
        print("A")
    default:
        print("A-")
}

switch grade {
case 0..<60:
    print("F")
case 60..<70:
    print("D")
case 70..<80:
    print("C")
case 80..<90:
    print("B")
case 90...100:
    if (grade % 5 == 0 && grade >= 90) {
        print("A")
    } else {
        print("A-")
    }
default:
    fatalError("Invalid grade")
}
