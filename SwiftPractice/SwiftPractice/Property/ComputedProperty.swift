import Foundation

class Human {
    var koreanAge: Int {
        get {
            print("getter")
            return self.koreanAge
        }
        set {
            print("setter")
            self.koreanAge = newValue
        }
    }
}

var human: Human = Human()
print(human.koreanAge)
human.koreanAge = 10
