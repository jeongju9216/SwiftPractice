//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/12.
//

import Foundation

struct Human: Codable {
    let name: String
}

let human: Human = Human(name: "애플")

let encoder: JSONEncoder = JSONEncoder()
if let encoded = try? encoder.encode(human) {
    print("type: \(type(of: encoded))")
    UserDefaults.standard.set(encoded, forKey: "Human")
}

let decoder: JSONDecoder = JSONDecoder()
if let data = UserDefaults.standard.object(forKey: "Human") as? Data,
   let human = try? decoder.decode(Human.self, from: data) {
    print("type: \(type(of: human))")
    print(human)
}


