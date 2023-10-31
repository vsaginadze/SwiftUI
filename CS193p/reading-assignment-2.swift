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

enum ASCIIControlCharacter: Character { 
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupyter, saturn, uranus, neptun
}

enum Compass: String {
    case north, south, west, east
}

let positionToFind = 4

if let possiblePlanet = Planet(rawValue: positionToFind) {
    switch possiblePlanet {
        case .earth:
            print("Mostly Harmless")
        default:
            print(" \(possiblePlanet) Isn't suitable for humans YET")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}





















































