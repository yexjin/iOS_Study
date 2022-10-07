//
//  FrameworkDetailViewController.swift
//  AppleFrameWork
//
//  Created by 오예진 on 2022/06/29.
//

import UIKit
import SafariServices   // 사파리를 띄우기 위한 Framework.
import Combine

class FrameworkDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var subscriptions = Set<AnyCancellable>()
    var viewModel: FrameworkDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        bind()
    }
    
    private func bind() {
        // input : Button 클릭
        // 구현할 logic :  framework -> url -> safari -> present
        viewModel.buttonTapped
            .receive(on: RunLoop.main)
            .compactMap { URL(string: $0.urlString) }
            .sink { [unowned self] url in
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
            }.store(in: &subscriptions)
         
        // output : Data setting될 떄, UI 업데이트
        viewModel.framework
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
                self.imageView.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
    }
    
    // Learn More 버튼을 클릭했을 때, Action target
    @IBAction func learnMoreTapped(_ sender: Any) {
        viewModel.learnMoreTapped( )
    }

}
