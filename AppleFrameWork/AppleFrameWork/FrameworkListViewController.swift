//
//  FrameworkListViewController.swift
//  AppleFrameWork
//
//  Created by 오예진 on 2022/05/27.
//

import UIKit

class FrameworkListViewController: UIViewController {
    
    // CollectionView 자체를 연결
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 데이터를 일단 가져오기
    let list: [AppleFramework] = AppleFramework.list
    
    // Data, Presentation, Layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DataSource는 ViewController 자신에게 물어보기(self)
        collectionView.dataSource = self
        
        // delegate를 통해서 Layout도 잘 위임
        collectionView.delegate = self
        
        // 네비게이션 바 title 바꾸기
        navigationController?.navigationBar.topItem?.title = "🎀 Apple Frameworks"
        
        // collectionView의 estimate size를 none으로 설정하는 코드
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.estimatedItemSize = .zero    // .zero 는 none으로 설정해준것과 같다.
        }
        
        // contentInset = Content의 안쪽 여백 주기
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16)
    }
    
}

// dataSource 프로토콜 준수 과정
extension FrameworkListViewController:
    UICollectionViewDataSource {
    
    // 몇개나 cell에 보여줄 건지?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else{
            return UICollectionViewCell()
        }
        
        let framework = list[indexPath.item] // 몇번째 아이템을 가져올건지는 index.item을 통해 가져올 수 있다.
        cell.configure(framework)
        return cell
    }
}

// delegate 프로토콜 준수 과정
extension FrameworkListViewController: UICollectionViewDelegateFlowLayout {
    
    // collectionView size를 automatic -> none 으로 바꿔주기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // item들간의 간격
        let interItemSpacing: CGFloat = 10
        
        // 좌우로 들어가는 16짜리 padding
        let padding: CGFloat = 16
        
        let width = (collectionView.bounds.width - interItemSpacing * 2 - padding * 2) / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    // cell 사이의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 윗줄과 아랫줄 (line spacing) 간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// item이 선택되었을 때 효과 넣기
extension FrameworkListViewController: UICollectionViewDelegate{
    
    // item이 선택되었을 때 호출되는 method
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item] // 몇번째 item인지?
        print(">>>> selected : \(framework.name)")
    }
}

