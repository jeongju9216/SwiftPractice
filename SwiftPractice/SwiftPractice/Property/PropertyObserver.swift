import Foundation

class Human {
    var nickname: String = "none"
    var name: String {
        get {
            print("[getter]")
            return "name"
        }
        set {
            print("[setter]")
            self.nickname = newValue + "!"
        }
    }
}

class Siri: Human {
    override var name: String {
        willSet {
            print("[willSet]")
        }
        didSet {
            print("[didSet]")
        }
    }
}

var siri: Siri = Siri()
siri.name = "애플"
