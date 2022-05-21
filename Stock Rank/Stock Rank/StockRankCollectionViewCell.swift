//
//  StockRankCollectionViewCell.swift
//  Stock Rank
//
//  Created by 오예진 on 2022/05/20.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    
    // UIcomponent 연결
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var diffLabel: UILabel!
    @IBOutlet weak var companyPriceLabel: UILabel!
    
    // UIcomponent에 데이터를 업데이트하는 코드를 넣기
    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyIconImageView.image = UIImage(named: stock.imageName)
        companyNameLabel.text = stock.name
        
        // 아래에 만든 convertToCurrencyFormat 써먹기
        companyPriceLabel.text = "\(convertToCurrencyFormat(price : stock.price)) 원"
        
        // 등락폭에 따라 text color 바꿔주기
        diffLabel.textColor = stock.diff > 0 ? UIColor.systemRed : UIColor.systemBlue
        
        diffLabel.text = "\(stock.diff)%"
    }
    
    // 가격을 세자리씩 끊기
    func convertToCurrencyFormat(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        // 소수점까지 보여줄 필요는 없으니까 maximumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        
        // nil인 경우에는 "" 빈 string을 넘겨주자 -> 실제 많이 사용되는 방식
        let result = numberFormatter.string(from: NSNumber(value: price)) ?? ""
        
        return result
    }
    

}
