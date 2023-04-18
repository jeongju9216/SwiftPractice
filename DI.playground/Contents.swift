import UIKit

protocol Numberable: AnyObject {
    var number: Int { get set }
}

class AClass: Numberable {
    var number: Int = 1
}

class BClass {
    var numberClass: Numberable
    
    init(numberClass: Numberable) {
        self.numberClass = numberClass
    }
}

let aClass = AClass()

let bClass = BClass(numberClass: aClass)
print(bClass.numberClass.number)
