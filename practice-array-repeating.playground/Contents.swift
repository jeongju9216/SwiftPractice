import UIKit

//Array(repeating:count:)에 숨어 있는 함정
//https://jeong9216.tistory.com/607
struct Item: Hashable, Identifiable {
    let id: UUID
    let value: Int
    
    init(id: UUID = UUID(), value: Int = 0) {
        print("Init: \(id)")
        self.id = id
        self.value = value
    }
}

var items = Array(repeating: Item(id: UUID()), count: 5)
for i in 0..<5 {
    print("[\(i)] uuid: \(items[i].id) / hash: \(items[i].hashValue)")
}

print("---2---")
var items2 = (1...5).map { _ in Item() }
for i in 0..<5 {
    print("[\(i)] uuid: \(items2[i].id) / hash: \(items2[i].hashValue)")
}

print("---3---")
var items3 = [Item(), Item(), Item(), Item(), Item()]
for i in 0..<5 {
    print("[\(i)] uuid: \(items3[i].id) / hash: \(items3[i].hashValue)")
}
