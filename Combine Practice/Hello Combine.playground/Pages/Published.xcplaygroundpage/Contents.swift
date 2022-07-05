//: [Previous](@previous)

import Foundation
import UIKit
import Combine

// @Published ?
// - @Published로 선언된 Property를 Publisher로 만들어줌
// - 클래스에 한해서 사용됨 (구조체에서 사용 X)
// - $을 이용해서 Publisher에 접근 가능

final class SomeViewModel {
    @Published var name: String = "Yejin"
    var age: Int = 23
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()
print("text: \(label.text)")
// text:

// $name: Publisher
// vm에 있는 data를 publisher로 만들어서 (== $name), name이 바뀔 때마다 label의 text에 있는 값이 바뀌도록 함.
vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")
// text: Yejin

vm.name = "Hey"
print("text: \(label.text)")
// text: Hey


//: [Next](@next)
