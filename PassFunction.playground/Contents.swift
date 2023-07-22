import UIKit

func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func sub(_ a: Int, _ b: Int) -> Int {
    return a - b
}

func processor(a: Int, b: Int, function: (Int, Int) -> Int) -> Int {
    return function(a, b)
}

processor(a: 1, b: 2, function: add) //3
processor(a: 2, b: 1, function: sub) //1
processor(a: 5, b: 2, function: {
    $0 * $1
}) //10
processor(a: 6, b: 2) {
    $0 / $1
} //3
