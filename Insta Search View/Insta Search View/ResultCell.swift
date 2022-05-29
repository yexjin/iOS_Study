//  ResultCell.swift

import UIKit

class ResultCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // cell 재사용을 준비하는 함수
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 재사용될 때는 기존의 이미지를 일단 없애주기 = reset!
        thumbnailImageView.image = nil
    }
    
    // 이미지 세팅
    func configure(_ imageName: String){
        thumbnailImageView.image = UIImage(named: imageName)
    }
    
}
