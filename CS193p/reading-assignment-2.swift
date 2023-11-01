// // func makeIncrementer(forIncrement amount: Int) -> () -> Int {
// //     var runningTotal = 0
    
// //     func increment() -> Int {
// //         runningTotal += amount
// //         return runningTotal
// //     }
    
// //     return increment
// // }

// // let incrementByTen = makeIncrementer(forIncrement: 10)

// // print(incrementByTen())
// // print(incrementByTen())
// // print(incrementByTen())
// // print(incrementByTen())

// // let alsoIncrementByTen = incrementByTen

// // print(alsoIncrementByTen())
// // print(incrementByTen())


// var completionHandlers: [() -> Void] = []

// func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
//     completionHandlers.append(completionHandler)
// }

// func someFunctionWithNonescapingClosure(closure: () -> Void) {
//     closure()
// }

// class SomeClass {
//     var x = 10
//     func doSomething() {
//         someFunctionWithEscapingClosure { self.x = 100 }
//         someFunctionWithNonescapingClosure { x = 200 }
//     }
// }

// let instance = SomeClass()
// instance.doSomething()
// print(instance.x)

// completionHandlers.first?()
// print(instance.x)

// struct SomeStruct {
//     var x = 10
//     mutating func doSomething() {
//         someFunctionWithNonescapingClosure { x = 200 }  // Ok
//         someFunctionWithEscapingClosure { x = 100 }     // Error
//     }
// }


// class SomeClass {
//     var completionHandler: (() -> Void)?

//     func doSomething(completion: @escaping () -> Void) {
//         completionHandler = completion
//     }

//     func runCompletionHandler() {
//         completionHandler?()
//     }
// }

// let obj = SomeClass()

// obj.doSomething {
//     print("Closure is escaping!")
// }

// // The closure is called outside the function scope, making it 'escape'
// obj.runCompletionHandler()

// enum ASCIIControlCharacter: Character {  
//      case tab = "\t"
//      case lineFeed = "\n"
//      case carriageReturn = "\r"
//  }
 
//  enum Planet: Int {
//      case mercury = 1, venus, earth, mars, jupyter, saturn, uranus, neptun
//  }
 
//  enum Compass: String {
//      case north, south, west, east
//  }
 
//  let positionToFind = 4
 
//  if let possiblePlanet = Planet(rawValue: positionToFind) {
//      switch possiblePlanet {
//          case .earth:
//              print("Mostly Harmless")
//          default:
//              print(" \(possiblePlanet) Isn't suitable for humans YET")
//      }
//  } else {
//      print("There isn't a planet at position \(positionToFind)")
//  }

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rectangle {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rectangle(origin: Point(x: 0, y: 0), size: Size(width: 10.0, height: 10.0))
var initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
 

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off

print(ovenLight)
ovenLight.next()

print(ovenLight)
ovenLight.next()
print(ovenLight)
ovenLight.next()
print(ovenLight)
ovenLight.next()

struct Fahrenheit {
    var temperature: Double = 32.0
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"

struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }

    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

print(boilingPointOfWater.temperatureInCelsius)

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

