//: [Previous](@previous)

import Foundation
import Combine

let arrayPublisher = [1, 2, 3].publisher

// background 실행을 위한 custom queue
let queue = DispatchQueue(label: "custom")

let subscription = arrayPublisher

    // publisher가 queue에서 실행되게 해줌
    .subscribe(on: queue)

    // operator
    .map { value -> Int in
        print("transform: \(value), thread: \(Thread.current)")
        return value
    }

    // 실제로 데이터를 받을 곳은 main thread
    .receive(on: DispatchQueue.main)

    // subscriber
    .sink { value in
        print("Received value: \(value), thread: \(Thread.current))")
    }


//transform: 1, thread: <NSThread: 0x600002cdc580>{number = 6, name = (null)}
//transform: 2, thread: <NSThread: 0x600002cdc580>{number = 6, name = (null)}
//transform: 3, thread: <NSThread: 0x600002cdc580>{number = 6, name = (null)}
//Received value: 1, thread: <_NSMainThread: 0x600002cd05c0>{number = 1, name = main})
//Received value: 2, thread: <_NSMainThread: 0x600002cd05c0>{number = 1, name = main})
//Received value: 3, thread: <_NSMainThread: 0x600002cd05c0>{number = 1, name = main})
// -> 이 출력 결과로 보듯이, custom number가 1이면 main thread 아니면 custom thread
// 보통, publisher의 생성, operator 작업은 heavy하기 때문엥,, background에서 돌린다
// 그때 이렇게 이용하면 될 것!


//: [Next](@next)
