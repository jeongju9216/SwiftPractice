import UIKit

struct Permissions: OptionSet {
    let rawValue: Int

    static let read = Permissions(rawValue: 1 << 0)
    static let write = Permissions(rawValue: 1 << 1)
    static let execute = Permissions(rawValue: 1 << 2)
}


var userPermissions: Permissions = [.read, .read, .write, .execute]
print(userPermissions.rawValue.nonzeroBitCount)

if userPermissions.contains(.read) {
    print("읽기 권한이 있습니다.")
}

if userPermissions.contains(.write) {
    print("쓰기 권한이 있습니다.")
}

if userPermissions.contains(.execute) {
    print("실행 권한이 있습니다.")
}
