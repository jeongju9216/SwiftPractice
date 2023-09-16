import UIKit

struct StructA {
    var value: Int = 0
}

class ClassA {
    var value: Int = 0
}

var structA = StructA() {
    didSet {
        print("[struct] didSet")
    }
}
var classA = ClassA() {
    didSet {
        print("[class] didSet")
    }
}

structA = StructA()
classA = ClassA()

structA.value = 10
classA.value = 10
