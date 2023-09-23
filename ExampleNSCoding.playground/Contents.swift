import UIKit

struct Point: Codable {
    let x: Double
    let y: Double
}

struct Size: Codable {
    let width: Int
    let height: Int
}

class Plane: NSObject, NSCoding {
    
    var shapes: [Shape]
    
    init(shapes: [Shape]) {
        self.shapes = shapes
    }
    
    // NSCoding
    required init?(coder: NSCoder) {
        self.shapes = coder.decodeObject(forKey: "shapes") as! [Shape]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(shapes, forKey: "shapes")
    }
    
    func display() {
        for shape in shapes {
            print(type(of: shape))
        }
    }
}

class Shape: NSObject, NSCoding {
    enum CodingKeys: String, CodingKey {
        case point, size
    }
    
    let point: Point
    let size: Size
    
    override var description: String {
        return "\(point), \(size)"
    }
    
    init(point: Point, size: Size) {
        self.point = point
        self.size = size
    }
    
    // NSCoding
    required init?(coder: NSCoder) {
        do {
            let pointData = coder.decodeObject(forKey: "point") as! Data
            let sizeData = coder.decodeObject(forKey: "size") as! Data
            
            self.point = try JSONDecoder().decode(Point.self, from: pointData)
            self.size = try JSONDecoder().decode(Size.self, from: sizeData)
        } catch {
            return nil
        }
    }
    
    func encode(with coder: NSCoder) {
        do {
            let pointData = try JSONEncoder().encode(point)
            let sizeData = try JSONEncoder().encode(size)
        
            coder.encode(pointData, forKey: "point")
            coder.encode(sizeData, forKey: "size")
        } catch {
            print(error)
        }
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
    
    required init?(coder: NSCoder) {
        self.text = coder.decodeObject(forKey: "text") as! String
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(text, forKey: "text")
        super.encode(with: coder)
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
    
    required init?(coder: NSCoder) {
        self.color = coder.decodeObject(forKey: "color") as! String
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(color, forKey: "color")
        super.encode(with: coder)
    }
}

func archive(with things: Plane) -> Data {
    do {
        let archived = try NSKeyedArchiver.archivedData(withRootObject: things, requiringSecureCoding: false)
        return archived
    } catch {
        print(error)
    }
    return Data()
}

func unarchive(with text: Data) -> Plane? {
    do {
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(text) as? Plane
    } catch {
        print(error)
    }
    return nil
}

let shapes: [Shape] = [
    Rect(point: .init(x: 10, y: 10), size: .init(width: 20, height: 20), text: "RECT1"),
    Circle(point: .init(x: 30, y: 30), size: .init(width: 40, height: 40), color: "CIRCLE1"),
    Rect(point: .init(x: 50, y: 50), size: .init(width: 60, height: 60), text: "RECT2"),
    Circle(point: .init(x: 70, y: 70), size: .init(width: 80, height: 80), color: "CIRCLE2")
]

let plane = Plane(shapes: shapes)

let archiveData = archive(with: plane)

if let plane = unarchive(with: archiveData) {
    plane.display()
}
