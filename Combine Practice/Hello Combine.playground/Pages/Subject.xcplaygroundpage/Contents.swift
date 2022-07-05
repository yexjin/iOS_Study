import Foundation
import Combine

// Subject : send(_:) 메소드를 이용해서 이벤트 값을 주입시킬 수 있는 Publisher
// Subject의 두가지 built-in type : PassthroughSubject, CurrentValueSubject



// 1. PassthroughSubject
// Output, Failure(Error) 타입을 설정해줘야 함
// Output 타입 : String
// Failure 타입 : Never (== 실패할리가 없다라는 뜻)
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")
//subscription1 received value: Hello
//subscription1 received value: World!




// 2. CurrentValueSubject
// PassthroughSubject와 마찬가지로 Output, Failure(Error) 타입을 설정해줘야 함
// 다른 점은, "초깃값" 설정!
let variable = CurrentValueSubject<String, Never>("")

// subscription하기 직전에 data를 보내면, 이게 초깃값으로 설정이 됨.
variable.send("Initial Data")

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
//subscription2 received value: Initial Data
//subscription2 received value: More text

// 묻혀진 데이터 확인하기
variable.value
// More text


// publisher을 통해 데이터 보내기 (== relay.send()역할을 하게 됨)
let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(relay)
//subscription1 received value: Here
//subscription1 received value: we
//subscription1 received value: go

// publisher.subscribe(variable) == variable.send() 역할
