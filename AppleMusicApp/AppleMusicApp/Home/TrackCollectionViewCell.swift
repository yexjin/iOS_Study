//
//  TrackCollectionViewCell.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/06.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackThumbnail: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    
    // awakeFromNib()
    // cell이 생성된 후 초기화 해주는 작업
    // ViewController의 ViewDidLoad 와 같은 역할
    // 호출되는 시점 : storyboard의 UIComponents들이 UICollectionView로 로드될 때
    override func awakeFromNib() {
        super.awakeFromNib()
        trackThumbnail.layer.cornerRadius = 4
        trackArtist.textColor = UIColor.systemGray2
        
    }
    
    // cell 업데이트 메소드
    func updateUI(item: Track?) {
        // TODO: 곡정보 표시
        guard let track = item else { return }
        trackThumbnail.image = track.artwork
        trackTitle.text = track.title
        trackArtist.text = track.artist
    }
}
