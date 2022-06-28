//
//  PaywallViewController.swift
//  SpotifyPaywall
//
//  Created by 오예진 on 2022/06/28.
//

import UIKit

class PaywallViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let bannerInfos: [BannerInfo] = BannerInfo.list
    let colors: [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed]
    
    // Section과 Item 꼭 잊지 말기
    enum Section {
        case main
    }
    typealias Item = BannerInfo
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presentation:  diffable datasource
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            // deque = 빼낸다는 의미
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
                return nil
            }
            cell.configure(item)
            cell.backgroundColor = self.colors[indexPath.item]  // 배경 색으로 아이템 구별
            return cell
        })

        // data: snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])    // snapshot에 section 붙여주기
        snapshot.appendItems(bannerInfos, toSection: .main)// snapshot에 item 추가하기
        datasource.apply(snapshot)
        
        // layout: compositional layout
        collectionView.collectionViewLayout = layout()
        
        // 위아래로 움직이는 거 막기
        collectionView.alwaysBounceVertical = false
        
        // 전체 페이지의 개수?
        pageControl.numberOfPages = bannerInfos.count
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered   // 수평방향으로!
        section.interGroupSpacing = 20  // 아이템들이 서로 떨어지게
        section.visibleItemsInvalidationHandler = { (item, offset, env) in
            
            // offset과 contentSize를 계산해서 index 결정하기
            let index = Int((offset.x / env.container.contentSize.width).rounded(.up))
            print(">>> \(index)")
            self.pageControl.currentPage = index
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
