import UIKit

func measureTime(_ closure: () -> ()) -> TimeInterval {
    let startDate = Date()
    closure()
    return Date().timeIntervalSince(startDate)
}

class Address {
    var item1: Int = 0
}

var array: ContiguousArray<Address> = []

var beforeCapacity = array.capacity
print("Capacity: \(beforeCapacity)")

for i in 0..<10000 {
    array.append(Address())
    
    if beforeCapacity != array.capacity {
        beforeCapacity = array.capacity
        print("Capacity: \(beforeCapacity)")
    }
}
