import UIKit

struct Point: Codable {
    let x: Double
    let y: Double
}

struct Size: Codable {
    let width: Int
    let height: Int
}

class Plane: Codable {
    
    var shapes: [Shape]
    
    init(shapes: [Shape]) {
        self.shapes = shapes
    }
    
    func display() {
        for shape in shapes {
            print("\(type(of: shape)): \(shape.description)")
        }
    }
}

class Shape: Codable {
    enum CodingKeys: String, CodingKey {
        case point, size
    }
    
    let point: Point
    let size: Size
    
    var description: String {
        return "Shape"
    }
    
    init(point: Point, size: Size) {
        self.point = point
        self.size = size
    }
    
    // Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.point = try container.decode(Point.self, forKey: .point)
        self.size = try container.decode(Size.self, forKey: .size)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(point, forKey: .point)
        try container.encode(size, forKey: .size)
    }
}

final class Rect: Shape {
    enum CodingKeys: String, CodingKey {
        case text
    }
    
    private let text: String
    
    override var description: String {
        "Rect\(super.description), Text:\(text)"
    }
    
    init(point: Point, size: Size, text: String) {
        self.text = text
        super.init(point: point, size: size)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try super.encode(to: encoder)
    }
}

final class Circle: Shape {
    enum CodingKeys: String, CodingKey {
        case color
    }
    
    private let color: String
    
    override var description: String {
        "Circle\(super.description), Color:\(color)"
    }
    
    init(point: Point, size: Size, color: String) {
        self.color = color
        super.init(point: point, size: size)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.color = try container.decode(String.self, forKey: .color)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(color, forKey: .color)
        try super.encode(to: encoder)
    }
}

func encode(with things: Plane) -> String {
    let jsonEncoder = JSONEncoder()
    do {
        let json = try jsonEncoder.encode(things)
        return String(data: json, encoding: .utf8) ?? ""
    }
    catch {
        print(error)
    }
    return ""
}

func decode(with text: String) -> Plane {
    let jsonDecoder = JSONDecoder()
    do {
        let jsonObject = try jsonDecoder.decode(Plane.self, from: text.data(using: .utf8) ?? Data())
        return jsonObject
    }
    catch {
        print(error)
    }
    return .init(shapes: [])
}


let shapes: [Shape] = [
    Rect(point: .init(x: 10, y: 10), size: .init(width: 20, height: 20), text: "RECT1"),
    Circle(point: .init(x: 30, y: 30), size: .init(width: 40, height: 40), color: "CIRCLE1"),
    Rect(point: .init(x: 50, y: 50), size: .init(width: 60, height: 60), text: "RECT2"),
    Circle(point: .init(x: 70, y: 70), size: .init(width: 80, height: 80), color: "CIRCLE2")
]

let plane = Plane(shapes: shapes)

let encodeData = encode(with: plane)

let decodingData = decode(with: encodeData)
decodingData.display()
