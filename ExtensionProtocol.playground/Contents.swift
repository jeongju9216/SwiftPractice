import UIKit

protocol Testable {
    var name: String { get }
    
    func hello()
    func bye()
}

extension Testable {
    var name: String {
        "시리"
    }
    
    func hello() {
        print("hello, \(name)")
    }
    
    func bye() {
        print("bye, \(name)")
    }
}

struct TestStruct: Testable {
    let name: String
}

let test: TestStruct = TestStruct(name: "정주")
test.hello() //hello, 정주
test.bye() //bye, 정주
