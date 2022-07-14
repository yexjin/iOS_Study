//: [Previous](@previous)
// 네트워크 담당객체 만들어보기

import Foundation

enum NetworkError: Error {
  case invalidRequest
  case transportError(Error)
  case responseError(statusCode: Int)
  case noData
  case decodingError(Error)
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
    
    // Result 타입으로 반환 == enum 타입 (failure, success)
    func fetchProfile(userName: String, completion: @escaping (Result<GithubProfile, Error>)-> Void) {
        
        // 요청을 위한 URL
        let url = URL(string: "https://api.github.com/users/\(userName)")!
        
        // 요청 이후에 받은 data, response, error
        // 문제 없는지 확인하는 작업들
        let task = session.dataTask(with: url) {data, response, error in
            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                return
                }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch let error as NSError{
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}


// network 담당, NetworkService
// NetworkService를 이용한, 네트워크 작업
let networkService = NetworkService(configuration: .default)

networkService.fetchProfile(userName: "yexjin") { result in
    switch result {
    case .success(let profile):
        print("Profile: \(profile)")
        // Profile: GithubProfile(login: "yexjin", avatarUrl: "https://avatars.githubusercontent.com/u/49095587?v=4", htmlUrl: "https://github.com/yexjin", followers: 8, following: 7)
    case .failure(let error):
        print("Error: \(error)")
    }
}



//: [Next](@next)
