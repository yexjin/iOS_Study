//
//  WeatherViewController.swift
//  Simple Weather
//
//  Created by 오예진 on 2022/05/17.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let cities = ["Seoul", "Tokyo", "LA", "Seattle"]
    let weathers = ["cloud.fill", "sun.max.fill", "wind", "cloud.sun.rain.fill" ]
    
    // 버튼이 눌렸을 때!
    @IBAction func changeButtonTapped(_ sender: Any) {
        
        // 도시가 랜덤으로
        cityLabel.text = cities.randomElement()
        
        // 날씨 이미지가 랜덤으로
        let imageName = weathers.randomElement()!
        weatherImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal )
        // 날씨 이미지가 랜덤으로 바뀔 때, 색이 이상하게 변하는 것을 방지하기 위해 withRenderingMode를 alwaysOriginal로!
        // 이렇게 안하거나 alwaysTemplate으로 설정하면 기본 tint color가 입혀진 이미지가 나타나게 된다.
        
        // 온도가 랜덤으로
        let randomTemp = Int.random(in:10..<30)
        temperatureLabel.text = "\(randomTemp)°"
    }

}
