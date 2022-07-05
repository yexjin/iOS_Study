//: [Previous](@previous)

import Foundation
import Combine

// 1. Publisher & Subscriber (Sink 이용)
let just = Just(1000)   // Publisher
// Publisher을 Subscriber 하기
let subscription1 = just.sink{ value in
    print("Received Value: \(value)")
}

// 데이터를 여러개 보내는 Publisher
let arrayPublisher = [1,3,5,7,9].publisher
let subscription2 = arrayPublisher.sink { value in
    print("Received Value: \(value)")
}


// 2. (assign 이용)
class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()

// arrayPublisher의 데이터들이 배출될 때마다 object 객체의 property에 할당 (== assign의 역할)
let subscription3 = arrayPublisher.assign(to: \.property, on: object)
//Did set property to 1
//Did set property to 3
//Did set property to 5
//Did set property to 7
//Did set property to 9

print("Final value: \(object.property)")
//Final value: 9








//: [Next](@next)


