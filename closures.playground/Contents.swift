import UIKit

let arr = [1, 2, 3, 4, 5, 6]

//func increment(by number: Int, to array: [Int]) -> [Int] {
//    var result: [Int] = []
//    for element in array {
//        result.append(element + number)
//    }
//    return result
//}

//func myMap(for array: [Int], _ transform: (Int) -> Int) -> [Int] {
//    var result: [Int] = []
//    for element in array {
//        result.append(transform(element))
//    }
//    return result
//}
extension Array {
    func myMap<T>(_ transform:(Element) -> T) -> [T] {
        var result: [T] = []
        for element in self {
            result.append(transform(element))
        }
        return result
    }
}

func myFilter(for array: [Int], _ transsform: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    for element in array {
        if transsform(element) {
            result.append(element)
        }
    }
    return result
}

//let result1 = numbers.myMap { $0 + 2}
let result1 = myFilter(for: arr, { $0 > 3 })
print(result1)

func countBits(_ n: Int) -> Int {
    var counter = 0
    var currentNumber = n
    while currentNumber > 0 {
        if currentNumber % 2 == 0 {
            counter += 0
        } else {
            counter += 1
        }
        currentNumber = currentNumber / 2
    }
    return counter
}

countBits(1234)


