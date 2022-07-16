//: [Previous](@previous)
// Combine을 통해, Network 객체들의 작업을 보기 좋게 간편하게 해보자.

import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest
    case responseError(statusCode: Int)
}

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}



final class NetworkService {
    
    let session: URLSession // init에서 생성된 URLSession을 property로 가지고 있게 하자
    
    init (configuration: URLSessionConfiguration){
        session = URLSession(configuration: configuration)
    }
    
    // GithubProfile을 반환하든지, Error을 반환해주든지
    func fetchProfile(userName: String) -> AnyPublisher<GithubProfile, Error>{
        
        // 요청을 위한 URL
        let url = URL(string: "https://api.github.com/users/\(userName)")!
    
        let publisher = session
            // 서버에서 받은 response 확인
            .dataTaskPublisher(for: url)
            .tryMap{result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                          let response = result.response as? HTTPURLResponse
                          let statusCode = response?.statusCode ?? -1
                          throw NetworkError.responseError(statusCode: statusCode)
                      }
                return result.data
            }
            
            .decode(type: GithubProfile.self, decoder: JSONDecoder())   // 디코딩을 도와주는 operator
            .eraseToAnyPublisher()  // type을 지우는 역할
        
        return publisher
    }
}

let networkService = NetworkService(configuration: .default)

let subscription = networkService
    .fetchProfile(userName: "yexjin")
    .receive(on: RunLoop.main)  // publisher을 main thread에서 받기
    .sink { completion in
        print("completion: \(completion)")
    } receiveValue: { profile in
        print("profile: \(profile)")
    }
//
//profile: GithubProfile(login: "yexjin", avatarUrl: "https://avatars.githubusercontent.com/u/49095587?v=4", htmlUrl: "https://github.com/yexjin", followers: 8, following: 7)
//completion: finished

//: [Next](@next)



