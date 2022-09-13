//
//  TrackCollectionHeaderView.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/06.
//

import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
    
    func update(with item: AVPlayerItem) {
        // TODO: 헤더뷰 업데이트
        
        self.item = item
        guard let track = item.convertToTrack() else { return }
        self.thumbnailImageView.image = track.artwork
        self.discriptionLabel.text = "Today's pic is \(track.artist)'s album - \(track.albumName), Let's listen."
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        // TODO: 탭했을때 처리
        
        guard let todaysItem = item else { return }
        tapHandler?(todaysItem)
        
    }
    
}

