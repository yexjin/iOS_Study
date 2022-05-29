//  SearchViewController.swift

import UIKit

class SearchViewController: UIViewController {

    // CollectionView 연결
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        if let flowlayout = CollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            // estimated size = none
            flowlayout.estimatedItemSize = .zero
        }
        
        // navigation title 달기
        self.navigationItem.title = "Search"
        
        // searchController을 Navigation bar 상단에 만들기
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self    // dataSource, delegate와 마찬가지로 위임을 확실히 하기위해 설정해줘야하는 메소드들이 있다.
        self.navigationItem.searchController = searchController
        
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    // item이 몇개가 필요? 24개 이미지!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
            return UICollectionViewCell()
        }
        let imageName = "animal\(indexPath.item + 1)"   // index는 0부터 시작하기 때문에 +1 해줌
        cell.configure(imageName)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    // cell 사이즈 조절
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing : CGFloat = 1
        let width = (collectionView.bounds.width - interItemSpacing * 2) / 3
        let height = width  // 정사각형
        return CGSize(width: width, height: height)
    }
    
    // item 좌우간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // item 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let search = searchController.searchBar.text
        print("search: \(search)")
    }
    
}


