import UIKit

class Student {
    let name: String
    lazy var greeting: () -> String = { [unowned self] in
        return "Hi, [\(self.name)]"
    }
    
    init(name: String) {
        print("Student(\(name)) init")
        
        self.name = name
    }
    
    deinit {
        print("Student(\(name)) deinit")
    }
}

var student1: Student? = Student(name: "팀쿡") //Student(팀쿡) init
print(student1!.greeting())

student1 = nil //Student(팀쿡) deinit
