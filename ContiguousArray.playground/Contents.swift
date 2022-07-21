import Foundation

public func measureTime(_ closure: () -> ()) -> TimeInterval {
    let startDate = Date()
    closure()
    return Date().timeIntervalSince(startDate)
}

class Address {
    var street = ""
    var city = ""
    var state = "";
    enum AddressAttributes {
        case Street
        case City
        case State
    }
    func updateAttribute(value: String, attribute: AddressAttributes){
        switch attribute {
        case .Street:
            street = value;
        case .City:
            city = value;
        case .State:
            state = value;
        }
    }
}

var array: Array<Address> = []
var contiguousArray: ContiguousArray<Address> = []

let item = Address()
let arrayTime = measureTime {
    for _ in 0..<100_000_000 {
        array.append(item)
    }
}

let contiguousArrayTime = measureTime {
    for _ in 0..<100_000_000 {
        contiguousArray.append(item)
    }
}

print("----- Append -----")
print("arrayTime: \(arrayTime)")
print("contiguousArrayTime: \(contiguousArrayTime)")
