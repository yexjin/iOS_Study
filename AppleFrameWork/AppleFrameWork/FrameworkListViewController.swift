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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    typealias Item = AppleFramework
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        navigationController?.navigationBar.topItem?.title = "🎀 Apple Frameworks"
        
    // Data, Presentation, Layout
//      (1) presentation -> diffable datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                 return nil
            }
            cell.configure(item)    // item이 AppleFramework와 같음
            return cell
        })
        
//      (2) data -> snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        // dataSource에 Snapshot을 적용시키기
        dataSource.apply(snapshot)
        
//      (3) layout -> compositional layout
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        // item, group, section, layout 만들기
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))    // item의 width는 group너비의 1/3, height는 group높이과 같음
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))    // group의 width는 section너비, height는 section너비의 1/3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)  // item을 3등분으로 균일하게 쓰겠다!
        
        let section = NSCollectionLayoutSection(group: group)
        // section 좌우에 안쪽패딩주기
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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


