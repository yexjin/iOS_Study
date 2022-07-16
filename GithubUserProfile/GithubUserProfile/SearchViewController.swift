//
//  SearchViewController.swift
//  GithubUserProfile
//
//  Created by 오예진 on 2022/07/16.
//

import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    
    // setupUI
    // userProfile
    // bind
    // searchControl
    // network
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published private(set) var user: UserProfile?

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        embedSearchControl()
        bind()
    }
    
    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "yexjin"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }
            .store(in: &subscriptions)
    }
    
    private func update(_ user : UserProfile?) {
        guard let user = user else {
            // user가 없을 경우,
            self.nameLabel.text = "n/a"
            self.loginLabel.text = "n/a"
            self.followersLabel.text = ""
            self.followingLabel.text = ""
            self.thumbnail.image = nil
            return
        }
        
        self.nameLabel.text = user.name
        self.loginLabel.text = user.login
        self.followersLabel.text = "follower: \(user.followers)"
        self.followingLabel.text = "following: \(user.following)"
        self.thumbnail.kf.setImage(with: user.avatarUrl)
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked: \(searchBar.text)")
        
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
        let base = "https://api.github.com/"
        let path = "users/\(keyword)"
        let params: [String:String] = [:]
        let header: [String:String] = ["Content-Type":"application/json"]
        
        var urlComponents = URLComponents(string: base+path)!
        let queryItems = params.map {(key: String, value: String) in
            return URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        // base부터 header까지 URLRequest로 만들기
        var request = URLRequest(url: urlComponents.url!)
        header.forEach{ (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // For Network
        // URLSession을 이용해서 data task 만들기 (Combine이용)
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap{ result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                          let response = result.response as? HTTPURLResponse
                          let statusCode = response?.statusCode ?? -1
                          throw NetworkError.responseError(statusCode: statusCode)
                      }
                return result.data
            }
            // 받은 데이터를 가지고 JSONDecoder을 이용하여  UserProfile로 Decoding
            .decode(type: UserProfile.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion: \(completion)")
                switch completion {
                case .failure(let error):
                    self.user = nil
                case .finished: break
                }
            } receiveValue: { user in
                // ViewController에 있는 User로 세팅!
                self.user = user
            }.store(in: &subscriptions)
    }
}
