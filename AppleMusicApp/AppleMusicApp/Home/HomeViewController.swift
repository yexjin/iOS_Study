//
//  HomeViewController.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/06.
//

import UIKit
import simd

class HomeViewController: UIViewController {
    
    // TODO: 트랙관리 객체
    let trackManager: TrackManager = TrackManager()

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 사용할 셀의 개수 = 트랙개수
        return trackManager.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else { return UICollectionViewCell()}
        
        // cell의 UI 업데이트 과정이 필요 -> TrackCollectionViewCell.swift에 구현
        let track = trackManager.track(at: indexPath.item)
        cell.updateUI(item: track)
        
        return cell
    }
    

    // 헤더뷰 표시
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // kind: supplementary view 종류 (header or footer)
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let item = trackManager.todayMusic else {
                return UICollectionReusableView()
            }
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath)as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            header.update(with: item)
        header.tapHandler = {item -> Void in
            // 아직 플레이어 화면 구현을 안했기 때문에 출력만 진행
            print("--> play \(item.convertToTrack()?.title)")
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

extension HomeViewController: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 곡 클릭시, 플레이어 뷰 띄우기
        
        //Player 스토리 보드를 저장 --> 그 스토리 보드 안에 여러가지 뷰컨트롤러 가 있는데 그 안에 특정 뷰컨트롤러를 가져오기 (storyboard id를 통해)
        let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
        
        guard let playerVC = playerStoryboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else { return }
        // instantiateViewController : 지정된 식별자(withIdentifier:)를 가지고 스토리보드의 데이터를 초기화 해 뷰 컨트롤러(=새로운 instance)를 만든다
        
        present(playerVC, animated: true, completion: nil)
        // present
        // - 뷰 위에 새로운 뷰가 얹어짐
        // - 세로방향 전개
        // - completion : 뷰 이동후 실행될 블록
        
    }
}
