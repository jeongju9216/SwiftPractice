import UIKit

var nsCache = NSCache<NSNumber, NSNumber>()
var dictionary = Dictionary<Int, Int>()

func addNumber() {
    usleep(200000)

    guard let value = dictionary[0] else {
        print("fail")
        return
    }
    
    print("dictionary: \(value)")
    dictionary.updateValue(value + 1, forKey: 0)
}

func addCacheNumber() {
    usleep(200000)

    guard let value = nsCache.object(forKey: NSNumber(value: 0)) else {
        print("cache fail")
        return
    }
    
    print("cache: \(value)")
    nsCache.setObject(NSNumber(value: Int(value) + 1), forKey: NSNumber(value: 0))
}

dictionary[0] = 0
nsCache.setObject(NSNumber(value: 0), forKey: NSNumber(value: 0))

for _ in 0..<5 {
    for i in 0..<100 {
        DispatchQueue.global().async {
//            addNumber() //Dictionary 업데이트
            addCacheNumber() //NSCache 업데이트
        }
    }
}


