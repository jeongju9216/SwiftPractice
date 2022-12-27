import UIKit

struct TestStruct {
    private var _testClass: TestClass
    
    var testClass: TestClass {
        mutating get {
            if !isKnownUniquelyReferenced(&_testClass) {
                print("Create New Object")
                _testClass = _testClass.copy() as! TestClass
            }
            
            return _testClass
        }
        
        set {
            _testClass = newValue
        }
    }
    
    init(testClass: TestClass) {
        self._testClass = testClass
    }
}

class TestClass: NSCopying {
    var number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return TestClass(number: self.number)
    }
}

var testClass: TestClass = TestClass(number: 1)
var testStruct1: TestStruct = TestStruct(testClass: testClass)
var testStruct2 = testStruct1

testStruct2.testClass.number = 2

print("testStruct1.testClass.number: \(testStruct1.testClass.number)") //1
print("testStruct2.testClass.number: \(testStruct2.testClass.number)") //2
