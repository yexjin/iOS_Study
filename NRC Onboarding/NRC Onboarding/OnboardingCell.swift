//  OnboardingCell.swift


import UIKit

class OnboardingCell: UICollectionViewCell {
    
    // component 연결
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // 데이터 연결
    func configure(_ message: OnboardingMessage){
        thumbnailImageView.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        descriptionLabel.text = message.description
    }
}
