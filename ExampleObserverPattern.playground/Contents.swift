import UIKit
import Combine

// 직접 구현
class Plane {
    var observers: [Shape]
    
    init(observers: [Shape]) {
        self.observers = observers
    }
    
    func subscribe(observer: Shape) {
        self.observers.append(observer)
    }
    
    func unsubscribe(observer: Shape) {
        if let index = observers.firstIndex(where: { $0.id == observer.id }) {
            self.observers.remove(at: index)
        }
    }
    
    func notify(message: String) {
        for observer in observers {
            observer.update(message: message)
        }
    }
}

class Shape {
    let id: UUID = UUID()
    
    func update(message: String) {
        print("[\(id)] update: \(message)")
    }
}

let plane = Plane(observers: [])
for _ in 0..<5 {
    plane.subscribe(observer: Shape())
}

plane.notify(message: "TEST")

// NotificationCenter
let customNotificationCenter = NotificationCenter()
class Plane2 {
    var observers: [Shape2] = []

    func subscribe(observer: Shape2) {
        observers.append(observer)
    }
    
    func unsubscribe(observer: Shape2) {
        if let index = observers.firstIndex(where: { $0.id == observer.id }) {
            self.observers.remove(at: index)
        }
    }
    
    func notify(message: String) {
        customNotificationCenter.post(
            name: Notification.Name("Notify"), //Plane-Notify 이름으로
            object: nil, //Plane2가
            userInfo: ["message": message]) //message를 포함해서 메시지를 보냄
    }
}

class Shape2 {
    let id: UUID = UUID()
    var cancellables: Set<AnyCancellable> = []
    
    deinit {
        customNotificationCenter.removeObserver(self)
    }
    
    init() {
        // NotificationCenter
        customNotificationCenter.addObserver(
            self,
            selector: #selector(update(notification:)),
            name: Notification.Name("Notify"),
            object: nil)
        
        // Combine
//        customNotificationCenter
//            .publisher(for: Notification.Name("Plane-Notify"))
//            .sink() { notification in
//                self.update(notification: notification)
//            }
//            .store(in: &cancellables)
    }
    
    @objc func update(notification: Notification) {
        guard let message = notification.userInfo?["message"] as? String else { return }
        print("[\(id)] update: \(message)")
    }
}

let plane2 = Plane2()
for _ in 0..<5 {
    plane2.subscribe(observer: Shape2())
}

plane2.notify(message: "TEST2")
