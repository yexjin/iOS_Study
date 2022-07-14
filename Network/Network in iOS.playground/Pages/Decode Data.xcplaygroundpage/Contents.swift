//: [Previous](@previous)
// 네트워크 Data Decoding
// 실제로 앱 내에서 사용하는 객체로 변환

// Decoding : JSON -> App Model

import Foundation

// Codable을 이용하면, JSON과 swift 객체 간 전환이 매우 쉬움
struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login  // key를 바로 가져다 씀
        case avatarUrl = "avatar_url"   // swift에서는 camelCase 스타일을 따르기에,,
        case htmlUrl = "html_url"   // JSON에서는 snack_case, swift에서는 camelCase
        case followers
        case following
    }
}


let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)

let url = URL(string: "https://api.github.com/users/yexjin")!

let task = session.dataTask(with: url) {data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
              print("--> response \(response)")
              return
          }
    
    
    guard let data = data else { return }   // 서버에서 받은 데이터
    // data -> GithubProfile
    
    do {
        let decoder = JSONDecoder()
        let profile = try decoder.decode(GithubProfile.self, from: data)  // GithubProfile 형태로 서버에서 받은 data를 디코딩
        print("profile: \(profile)")
    } catch let error as NSError{
        print("error: \(error)")
    }
}

task.resume()






//: [Next](@next)
