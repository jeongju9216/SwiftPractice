import UIKit

@propertyWrapper
class Dependency<T> {
    
    let wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyContainer.resolve()
    }
}

final class DependencyContainer {
    private static var shared = DependencyContainer()
    
    private init() { }
    
    private var dependencies: [String: Any] = [:]

    static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }

    static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T

        precondition(dependency != nil, "\(key) Dependency가 없음")
        
        return dependency!
    }
}

protocol Eattable {
    func eat()
}

struct Chicken: Eattable {
    func eat() {
        print("치킨을 냠냠")
    }
}

protocol Drinkable {
    func drink()
}

struct Beer: Drinkable {
    func drink() {
        print("맥주를 꼴깍꼴깍")
    }
}

struct Restaurant {
    var food: Eattable
    var drink: Drinkable
    
    init(food: Eattable, drink: Drinkable) {
        self.food = food
        self.drink = drink
    }
    
    func sell() {
        food.eat()
        drink.drink()
    }
}

//let chicken = Chicken()
//let beer = Beer()
//
//let chickenRestaurant = Restaurant(food: chicken, drink: beer)
//chickenRestaurant.sell()

DependencyContainer.register(Chicken())
DependencyContainer.register(Beer())

let chicken: Chicken = DependencyContainer.resolve()
let beer: Beer = DependencyContainer.resolve()

DependencyContainer.register(Restaurant(food: chicken, drink: beer))

class Test {
    @Dependency var chickenRestaurant: Restaurant
    
    init() {

    }
    
    func test() {
        chickenRestaurant.sell()
    }
}

let test = Test()
test.test()
