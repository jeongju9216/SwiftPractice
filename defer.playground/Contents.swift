import Foundation

func functionA() {
    print("In functionA")
    
    defer {
        print("Out 1")
    }
    
    defer {
        print("Out 2")
    }
}

functionA()

if true {
    defer {
        print("Out if")
    }
    
    print("In if")
}

let value: Int? = nil
func functionB() {
    defer {
        print("Out functionB 1")
    }
    
    guard let value = value else {
        return
    }
    
    defer {
        print("Out functionB 2")
    }
}

functionB()
