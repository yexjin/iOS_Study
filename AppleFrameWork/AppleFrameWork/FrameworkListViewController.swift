//
//  FrameworkListViewController.swift
//  AppleFrameWork
//
//  Created by 오예진 on 2022/05/27.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {
    
    // CollectionView 자체를 연결
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    typealias Item = AppleFramework
    
    enum Section {
        case main
    }
    
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    @Published var list: [AppleFramework] = AppleFramework.list
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self  // collectionView의 위임을 나에게 하겠다. 내가 담당하겠다!
        navigationController?.navigationBar.topItem?.title = "🎀 Apple Frameworks"
        
        configureCollectionView()
        
        bind()
        
    }
    
    private func bind() {
        // input: 사용자 인풋을 받아서 처리해야할 것
        // - item 선택되었을 때 처리
        didSelect
            .receive(on: RunLoop.main)  // UI 변경이니, main thread에서 일어날 수 있게 하기
            .sink { [unowned self] framework in
            let storyboard = UIStoryboard(name: "Detail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
            vc.framework = framework
            self.present(vc, animated: true)
        }.store(in: &subscriptions)
        
        // output: data, state 변경에 따라서, UI 업데이트 할 것
        // - items 세팅이 되었을 때, 컬랙션뷰를 업데이트
        $list
            .receive(on: RunLoop.main )
            .sink { [unowned self] list in
                self.applySectionItems(list)
            }.store(in: &subscriptions)
    }
    
    // Collection View Presentation, Layout 설정
    private func configureCollectionView() {
        
        // presentation -> diffable datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                 return nil
            }
            cell.configure(item)    // item이 AppleFramework와 같음
            return cell
        })
        
        // layout -> compositional layout
        collectionView.collectionViewLayout = layout()
        
    }
    
    // Collection View Data 설정
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        
        // data -> snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        // dataSource에 Snapshot을 적용시키기
        dataSource.apply(snapshot)
        
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
        
        // 데이터 보내기!
        didSelect.send(framework)
    }
}


