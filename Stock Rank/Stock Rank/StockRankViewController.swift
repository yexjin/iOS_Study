//
//  StockRankViewController.swift
//  Stock Rank
//
//  Created by 오예진 on 2022/05/19.
//

import UIKit

class StockRankViewController: UIViewController {
    
    // Data 가져오기
    let stockList: [StockModel] = StockModel.list


    @IBOutlet weak var collectionView: UICollectionView!
    
    // CollectionView를 사용하기 위해 필요한 3가지!
    // Data, Presentation, Layout
    // Data - 어떤 데이터? -> stockList
    // Presentation - 셀을 어떻게 표현?
    // Layout - 셀을 어떻게 배치?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Protocol : dataSource, delegate
        // dataSource : viewController가 collectionView에게 데이터가 어떻게 될 것인지 알려줌
        collectionView.dataSource = self
        // delegate : 레이아웃이나 셀의 사이즈 등이 어떻게 될 것인지 알려줌 (어떻게 배치할 것인지?)
        collectionView.delegate = self
        // self : 내가 알려줄거야~
    
    }
}

extension StockRankViewController: UICollectionViewDataSource {
    
    // 몇개의 데이터를 가져올 것인지?
    // == CollectionView에게 몇개의 cell이 필요하냐
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    
    // 각 셀을 어떻게 표현할 것인지?
    // == indexPath번째에 해당하는 item을 UICollectionViewCell 형태로 어떻게 표현할 거냐
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard <<꼭 참이어야하는 조건>> else {
//            return 참이 아닐때 실행
//        }
//        
//        참일때 실행
        
        // dequeueReusableCell : 재사용이 가능한 cell을 가져오겠다!
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        // cell을 StockRankCollectionViewCell로 커스팅을 시켜놓기
        
        let stock = stockList[indexPath.item]
        // indexPath에는 section에 대한 정보 즉, section 안에 들어가는 각 데이터(Row)에 대한 정보들이 있다.
        // [indexPath.item] == item에 대한 정보가 몇번째에 있는지를 알려준다.
        
        cell.configure(stock)
        return cell
    }
    
    
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // width == collectionView
        // height == 80
        
        // collectionView의 width 가져오기 == collectionView.bounds.width
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
}
