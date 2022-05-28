//
//  FrameworkCell.swift
//  AppleFrameWork
//
//  Created by 오예진 on 2022/05/27.
//

import UIKit

class FrameworkCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.numberOfLines = 1
        
        // font 사이즈를 셀에 따라 맞게 조절
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    // cell을 업데이트 해줄 수 있는 method 추가
    func configure(_ framework: AppleFramework){
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
}
