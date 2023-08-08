import UIKit

class Time {
    var hour: Int
    var minute: Int
    
    init?(hour: Int, minute: Int) {
        guard 1...12 ~= hour, 0...59 ~= minute else {
            return nil
        }
        
        self.hour = hour
        self.minute = minute
    }
    
    init!(minute: Int) {
        guard 0...59 ~= minute else {
            return nil
        }
        
        self.hour = 1
        self.minute = minute
    }
    
    init(hour: Int) {
        self.hour = hour
        self.minute = 0
    }
}

print(Time(hour: 1, minute: 30)) //OK
print(Time(hour: 13, minute: 30)) //nil

//let time: Time = Time(hour: 13, minute: 30) //comple error
//let time1: Time = Time(minute: -1) //runtime error
let time2: Time = Time(minute: 10)
print(time2)

enum Color: String {
    case Red, Green, Blue, Black
}

print(Color(rawValue: "Red"))
print(Color(rawValue: "Yellow"))

class ParentA {
    var age: Int
    var name: String

    init?(age: Int, name: String) {
        if age < 0 || name.isEmpty {
            return nil
        }
        self.age = age
        self.name = name
    }
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.age = 1
        self.name = name
    }
    
    init() {
        self.age = 1
        self.name = "unknown"
    }
}

class ChildA: ParentA {
    override init!(age: Int, name: String) {
        if age < 10 || name.isEmpty {
            return nil
        }
        super.init(age: age, name: name)
    }

//    convenience override init(name: String) {
//        self.init(age: 10, name: name)
//    }

    override init(name: String) {
        super.init(name: name)!
        self.age = 10
    }
}

let childA = ChildA(name: "jeong")
print(childA)
