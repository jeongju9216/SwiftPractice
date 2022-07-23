import Foundation

struct Human {
    var name: String = "이름"
    var age: Int
    
    var koreanAge: Int {
        get {
            return koreanAge + 1
        }
        set(newAge) {
            self.koreanAge = 10
        }
    }
}

var human: Human = Human(age: 10)
print("human age: \(human.age) / koreanAge: \(human.koreanAge)")

human.koreanAge = 10
