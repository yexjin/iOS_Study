//
//  SymbolViewController.swift
//  Symbol Roller
//
//  Created by 오예진 on 2022/05/12.
//

import UIKit

class SymbolViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]

    func reload() {
            // TO_DO
            // - 심볼에서, 하나를 임의로 추출해서
            // - 이미지와 텍스트 설정을 한다.
            let symbol = symbols.randomElement()!
            imageView.image = UIImage(systemName: symbol)
            label.text = symbol
        }
    
    // app 실행 시, viewDidLoad()를 거쳐서 뜬다.
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        
        // 버튼의 tintColor 바꾸기
        button.tintColor = UIColor.systemPink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // @IBAction : 클릭이 됐을 때, 어떤 것을 수행하겠다.
    @IBAction func buttonTapped(_ sender: Any) {
        reload()
    }


}
