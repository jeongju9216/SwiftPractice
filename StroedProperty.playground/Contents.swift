import Foundation

class House {
    var address: String = ""
    var name: String = ""
    
    init() {
        print("Create House!")
    }
}

class Database {
    var name: String = "House Data"
    lazy var houses: [House] = Array(repeating: House(), count: 100_000)
}

var database1: Database = Database()
var database2: Database = Database()
var database3: Database = Database()
var database4: Database = Database()
var database5: Database = Database()

