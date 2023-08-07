import UIKit

class ClassA {
    var num: Int
    var name: String
    
    init(num: Int, name: String) {
        self.num = num
        self.name = name
    }
    
    convenience init(num: Int) {
        self.init(num: num, name: "jeong")
    }
}


struct StructA {
    var num: Int
    var name: String
    
    init(num: Int, name: String) {
        self.num = num
        self.name = name
    }
    
    init(num: Int) {
        self.init(num: num, name: "jeong")
    }
}

let classA = ClassA(num: 10)
let structA = StructA(num: 10)

print(classA.num)
print(structA)
