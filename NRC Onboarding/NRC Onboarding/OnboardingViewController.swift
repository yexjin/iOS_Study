//
//  OnboardingViewController.swift
//  NRC Onboarding
//
//  Created by 오예진 on 2022/05/30.
//

import UIKit

class OnboardingViewController: UIViewController {

    // collectionView 연결
    @IBOutlet weak var collectionView: UICollectionView!
    
    // pageControl 연결
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 메세지 가져오기
    let messages: [OnboardingMessage] = OnboardingMessage.messages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        // 페이지 개수 ( 동그란 점의 개수 )
        pageControl.numberOfPages = messages.count

    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else{
            return UICollectionViewCell()
        }
        
        // messages에서 item을 가져와서 cell을 구성
        let message = messages[indexPath.item]
        cell.configure(message)
        return cell
    }
    
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
     
    // cell 사이즈 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // cell과 collectionView의 사이즈가 같음
        return collectionView.bounds.size   // size 프로퍼티 안에 width, height 모두 있음.

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // 페이지 구하는 식
//        print(Int(scrollView.contentOffset.x / self.collectionView.bounds.width))
//    }
    
    // 페이지가 움직이다가 멈췄을 때 실행되는 함수
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 위에서 페이지 구하는 식 가져오기
        let index = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)
        
        // 이 index를 currentPage에 업데이트!
        pageControl.currentPage = index
    }
}
