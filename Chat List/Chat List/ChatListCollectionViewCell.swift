//
//  ChatListCollectionViewCell.swift
//  Chat List
//
//  Created by 오예진 on 2022/05/22.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 10 
    }
    
    // Chat.swift 파일에 있는 내용을 받아서 내용 업데이트
    func configure(_ chat: Chat){
        
        
        thumbnail.image = UIImage(named: chat.name)
        nameLabel.text = chat.name
        chatLabel.text = chat.chat
        dateLabel.text = formattedDateString(dateString: chat.date)
        chatLabel.numberOfLines = 2
    }
    
    func formattedDateString(dateString: String) -> String {
        
        // String -> Date -> String 순으로 변환시켜줘야함.
        // 2022-04-01 > 4/1
        
        // DateFormatter() 객체 이용
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        // String -> Date 변환
        if let date = formatter.date(from: dateString){
            formatter.dateFormat = "M/d"
            
            // Date -> String 변환
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
