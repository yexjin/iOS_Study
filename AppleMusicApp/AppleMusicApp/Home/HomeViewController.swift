//
//  HomeViewController.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/06.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    

    // 헤더뷰 표시
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // kind: supplementary view 종류 (header or footer)
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath)as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20 - card(width) - 20
        
        let itemSpacing: CGFloat = 20
        let margin: CGFloat = 20
        let width = (collectionView.bounds.width -  itemSpacing - margin * 2) / 2
        let height = width + 60
        
        return CGSize(width: width, height: height)
    }
}
