//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// iOS에서 자동으로 제공해주는 Publisher : URLSessionTask, Notification, Timer ...


// (1) URLSessionTask Publisher and JSON Decoding Operator
struct SomeDecodable: Decodable { }

URLSession.shared.dataTaskPublisher(for: URL(string: "http://www.google.com")!)
    .map{ data, response in
        return data
    }
    .decode (type: SomeDecodable.self, decoder: JSONDecoder())




// (2) Notifications

let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
// publisher가 noti에 대해서 data를 publishing하겠다는 의미
let notiPublisher = center.publisher(for: noti, object: nil)
// noti를 받으면 print문이 실행되게!
let subscription1 = notiPublisher.sink { _ in
    print("Noti Received")
}
// noti 보내보기
center.post(name: noti, object: nil)
// Noti Received

// subscription1 구독 해ㅊ제
subscription1.cancel()




// (3) KeyPath binding to NSObject instances

let ageLabel = UILabel()
print("text: \(ageLabel.text)")
// text: nil

Just(28)
    .map { "Age is \($0)"}
    .assign(to: \.text, on: ageLabel)
print("text: \(ageLabel.text)")
// text: Optional("Age is 28")




// (4) Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함 (알아서 동작!)
let TimerPublihser = Timer
    .publish(every: 1, on: .main, in: .common)  // 1초마다 배출
    .autoconnect()

let subscription2 = TimerPublihser.sink{ time in
    print("time: \(time)")
}

// 5초정도는 진행한 뒤, subscription cancel!
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscription2.cancel()
}

//time: 2022-07-05 10:32:49 +0000
//time: 2022-07-05 10:32:50 +0000
//time: 2022-07-05 10:32:51 +0000
//time: 2022-07-05 10:32:52 +0000
//time: 2022-07-05 10:32:53 +0000

//: [Next](@next)
