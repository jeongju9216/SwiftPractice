import Foundation

let arr1 = [1, 2, 3, 4]
let arr2 = [1, 3, 4, 5]

let diff = arr2.difference(from: arr1)
for item in diff {
    switch item {
    case .insert(let offset, let element, _):
        print("\(offset)번 offset에 \(element)가 추가되었습니다.")
    case .remove(let offset, let element, _):
        print("\(offset)번 offset의 \(element)가 삭제되었습니다.")
    }
}

let arr3 = arr1.applying(diff)
print(arr3)
