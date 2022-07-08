//: [Previous](@previous)

import Foundation
import Combine

// CombineLatest ?
// - 추가적인 publisher을 subscribe


// <1> Basic CombineLatest
let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

strPublisher.combineLatest(numPublisher).sink { (str, num) in
    print("Received: \(str), \(num)")
}
// 위와 같은 기능을 하는 코드
// Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
// print("Received: \(str), \(num)")
// }


strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")
numPublisher.send(2)
numPublisher.send(3)
//Received: a, 1
//Received: b, 1
//Received: c, 1
//Received: c, 2
//Received: c, 3


// <2> Advanced CombineLatest
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

// valid 한가?
let validatedCredentialsSubscription = usernamePublisher.combineLatest(passwordPublisher)
    .map{(username, password) -> Bool in
        return !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink{ valid in
        print("Credential Valid: \(valid)")
    }

usernamePublisher.send("yejin")
passwordPublisher.send("weekpw")
//Credential Valid: false

passwordPublisher.send("strong password!")
//Credential Valid: true




// <3> Merge
// combineLatest는 두 publisher의 output 타입이 같지 않아도 상관없는데,
// Merge는 두 publisher의 output 타입이 같아야 한다.
let publisher1 = [1, 2, 3, 4].publisher
let publisher2 = [100, 200, 300].publisher

let mergePublisherSubscription = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merge: subscription received value: \(value)")
    }
// 위와 같은 기능을 하는 코드
// let mergePublisherSubscription = Publishers.Merge(publisher1, publisher2)

//Merge: subscription received value: 1
//Merge: subscription received value: 2
//Merge: subscription received value: 3
//Merge: subscription received value: 4
//Merge: subscription received value: 100
//Merge: subscription received value: 200
//Merge: subscription received value: 300


//: [Next](@next)
