//
//  FrameworkDetailViewController.swift
//  AppleFrameWork
//
//  Created by 오예진 on 2022/06/29.
//

import UIKit
import SafariServices   // 사파리를 띄우기 위한 Framework.

class FrameworkDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        imageView.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    
    // Learn More 버튼을 클릭했을 때, Action target
    @IBAction func learnMoreTapped(_ sender: Any) {
    
    // url 객체 만들기
        guard let url = URL(string: framework.urlString) else {
            return
        }
    
    // Safari View Controller
    let safari = SFSafariViewController(url: url)
    present(safari, animated: true)
        
    }

}
