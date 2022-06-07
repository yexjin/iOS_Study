//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 오예진 on 2022/06/04.
//

import UIKit

class FocusViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var currated: Bool = false
    
    var items: [Focus] = Focus.list
    
    typealias Item = Focus
    enum Section {
        case main
        // Section이 많아지면 여기에 case를 더 추가하면 됨.
    }
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshButton.layer.cornerRadius = 10
        
        // (1) presentation -> DiffableDataSource
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // (2) data -> Snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        datasource.apply(snapshot)
        // snapshot을 설정해주면, 이 정보말고 나머지는 가짜라고 설정된다.
        
        // (3) laout -> Compositional layout
        collectionView.collectionViewLayout = layout()
        
        updateButtonTitle()

    }
    
    private func layout() -> UICollectionViewCompositionalLayout{
        
        // .estimated(50) == 기본적으로 50인데 그저 추정값, 늘어남에 따라서 알아서 표현이 된다.
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        // section에 좌우패딩주기
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        // group간의 spacing
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    func updateButtonTitle() {
        let title = currated ? "See All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        currated.toggle()
        
        self.items = currated ? Focus.recommendations : Focus.list
        
        // collectionView가 업데이트 되어야 함
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        datasource.apply(snapshot)
        
        updateButtonTitle()
    }
    
}
