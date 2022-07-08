//: [Previous](@previous)

import Foundation
import Combine

// <1> Transform - Map : value 가공
let numPublisher = PassthroughSubject<Int, Never>()
let subscription1 = numPublisher
    .map{ $0 * 2 }
    .sink { value in
        print("Transformed value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
subscription1.cancel()
//Transformed value: 20
//Transformed value: 40
//Transformed value: 60


// <2> Filter : 특정 조건을 만족하는 value만을 filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }    // operating : "a"를 포함ㅎ한 것만 filter
    .sink { value in
        print("Filtered value: \(value)")
    }

stringPublisher.send("abc")
stringPublisher.send("None")
stringPublisher.send("apple")
stringPublisher.send("bike")
subscription2.cancel()
//Filtered value: abc
//Filtered value: apple


//: [Next](@next)
