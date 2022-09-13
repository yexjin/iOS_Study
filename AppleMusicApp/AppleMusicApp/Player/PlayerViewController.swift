//
//  PlayerViewController.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/13.
//

import UIKit

class PlayerViewController:
    UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playControlButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

}
