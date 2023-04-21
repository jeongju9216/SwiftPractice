import UIKit

enum MusicType {
    case classic, band
}

//Product
protocol Music {
    var name: String { get set }
}

//Concrete Product
struct Classic: Music {
    var name: String
}

struct Band: Music {
    var name: String
}

//Product
protocol Instrument {
    func play()
}

//Concrete Product
struct Violin: Instrument {
    func play() {
        print("Play Violin")
    }
}

struct Guitar: Instrument {
    func play() {
        print("Play Guitar")
    }
}

//Abstract Factory
protocol MusicianFactory {
    func createMusic(name: String) -> Music
    func createInstrument() -> Instrument
}

//Factory
struct ViolinistFactory: MusicianFactory {
    func createMusic(name: String) -> Music {
        return Classic(name: name)
    }
    
    func createInstrument() -> Instrument {
        return Violin()
    }
}

struct GuitaristFactory: MusicianFactory {
    func createMusic(name: String) -> Music {
        return Band(name: name)
    }
    
    func createInstrument() -> Instrument {
        return Guitar()
    }
}
