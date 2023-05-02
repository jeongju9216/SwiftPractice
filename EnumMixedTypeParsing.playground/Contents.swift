import UIKit

let mixedData = """
[{
    "type": "movie",
    "id": 100,
    "title": "타이타닉",
    "country": "USA"
},
{
    "type": "person",
    "id": 101,
    "name": "레오나르도 디카프리오",
    "role": "Actor"
},
{
    "type": "music",
    "id": 102,
    "title": "My Heart Will Go On",
    "artist": "Céline Dion"
}]
""".data(using: .utf8)!

enum Content {
    case movie(Movie)
    case person(Person)
    case music(Music)
}

struct Movie: Codable {
    let id: Int
    let title: String
    let country: String
}

struct Person: Codable {
    let id: Int
    let name: String
    let role: String
}

struct Music: Codable {
    let id: Int
    let title: String
    let artist: String
}

extension Content: Codable {
    private enum CodingKeys: String, CodingKey {
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleContainer = try decoder.singleValueContainer()
        
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "movie":
            let movie = try singleContainer.decode(Movie.self)
            self = .movie(movie)
        case "person":
            let person = try singleContainer.decode(Person.self)
            self = .person(person)
        case "music":
            let music = try singleContainer.decode(Music.self)
            self = .music(music)
        default:
            fatalError("Unknown type of content.")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()
        
        switch self {
        case .movie(let movie):
            try singleContainer.encode(movie)
        case .person(let person):
            try singleContainer.encode(person)
        case .music(let music):
            try singleContainer.encode(music)
        }
    }
}

let decoder = JSONDecoder()
let content = try decoder.decode([Content].self, from: mixedData)
print(content)
