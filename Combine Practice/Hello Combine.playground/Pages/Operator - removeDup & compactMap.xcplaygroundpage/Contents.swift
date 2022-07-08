//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// <1> removeDuplicates : 중복 제거!
let words = "hey hey hey There! Mr. Mr."
    .components(separatedBy: " ")
    .publisher

words
    .removeDuplicates()
    .sink { value in
        print(value)
    }.store(in: &subscriptions) // subscriptions에 저장!
//hey
//There!
//Mr.



// <2> compactMap
let strings = ["a", "1.24", "3", "def", "46", "8.23"].publisher

strings
    .compactMap{ Float($0) }
    .sink { value in
        print(value)
    }.store(in: &subscriptions)
//1.24
//3.0
//46.0
//8.23



// <3> ignoreOutput : 모든 upstream elements를 무시, 하지만 fail이나 finish 관련 메시지는 출력
let numbers = (1...10_000).publisher

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)

//Completed with: finished

// <4> prefix
// - prefix(2) ? 앞의 두개만 받고 끝내겠다.
let tens = (1...10).publisher

tens
    .prefix(2)
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)
//1
//2
//Completed with: finished


//: [Next](@next)
