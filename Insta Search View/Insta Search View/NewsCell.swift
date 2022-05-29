//
//  NewsCell.swift
//  Insta Search View
//
//  Created by 오예진 on 2022/05/29.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    // cell 재사용을 준비하는 함수
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 재사용될 때는 기존의 이미지를 일단 없애주기 = reset!
        imageView.image = nil
    }
    
    // cell 세팅
    func configure(_ imageName: String){
        imageView.image = UIImage(named: imageName)
    }
    
}
