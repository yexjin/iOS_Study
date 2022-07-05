//: [Previous](@previous)

import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

// subscription?
// - Subscriber가 Publisher와 연결됨을 나타냄 (like 구독티켓!)
// - Cancellable protocol을 따르고 있음

let subscription = subject
//    The print() operator prints you all lifecycle events (like debug)
//    .print()
    .sink { value in
        print("Subscriber received value: \(value)")
    }

subject.send("Hello")
subject.send("World")
subject.send("Hello for the last time")
subject.send(completion: .finished) // receive finished
// subscriber.cancel(): subject.send(completion: .finished) 처럼
// 보내는 사람 뿐만 아니라, 구독자도 관계를 끊어낼 수 있음
// receive cancle

subject.send("Hello? :(")   // 관계가 종료되어서 안보내짐
//Subscriber received value: Hello
//Subscriber received value: World
//Subscriber received value: Hello for the last time

//: [Next](@next)
