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
    
    init(num: Int) {
        self.num = num
        self.name = "jeong"
    }
}
