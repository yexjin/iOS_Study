//
//  ChatListViewController.swift
//  Chat List
//
//  Created by 오예진 on 2022/05/22.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var chatList: [Chat] = Chat.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data, Presentation, Layout
        
        // dataSource : data와 presentation을 표현해주는 것을 누군가에게 위임해주는 역할
        collectionView.dataSource = self    // self : 바로 viewController 나야 나
        // delegate : Layout도 누군가에게 위임
        collectionView.delegate = self  // 이것도 viewController
        // self = 위임당하는 객체로 바로 viewController 자신임
        
        // closure 표현방법을 통해서 sort 함수 이용
        chatList = chatList.sorted(by: {chat1, chat2 in return chat1.date > chat2.date})
        // -> date에 따라 역순으로 정렬된 chatList가 출력된다.

    }

}

// dataSource와 delegate 프로토콜을 준수하기 위한 extension (각 프로토콜에 필요한 메소드들을 작성)
extension ChatListViewController: UICollectionViewDataSource {
    
    // CollectionView에 표현되는 아이템의 개수가 몇개인지 = chat list의 개수만큼!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }
    
    // cell을 어떻게 표현할지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 재사용 구분자를 이용하여 cell을 가져오기
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as? ChatListCollectionViewCell else {
            return UICollectionViewCell()   // 캐스팅이 실패한 경우 실행
        }
        
        // 캐스팅에 성공한 경우 실행되는 아래의 코드
        let chat = chatList[indexPath.item]
        cell.configure(chat)
        return cell
    }
    
}

// for Layout
// ChatListViewController가 FlowLayout에 대한 역할을 위임받을 것이다.
extension ChatListViewController: UICollectionViewDelegateFlowLayout{
    
    // Cell의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
}
