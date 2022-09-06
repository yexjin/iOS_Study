//
//  TrackCollectionHeaderView.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/06.
//

import UIKit

class TrackCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
    
}

