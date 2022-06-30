//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 오예진 on 2022/06/30.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
