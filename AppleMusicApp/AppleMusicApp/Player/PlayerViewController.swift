//
//  PlayerViewController.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/13.
//

import UIKit
import CoreMedia

class PlayerViewController:
    UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playControlButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    
    //TODO: SimplePlayer 만들고 프로퍼티 추가
    let simplePlayer = SimplePlayer.shared
    
    var timeObserver: Any?  // 현재 재생되는 item의 시간을 일정하게 관찰하는 프로퍼티
    var isSeeking: Bool = false
    
    // 로드 시 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayButton()
        updateTime(time: CMTime.zero)
        
        // TODO: Time Observer 구현
        // - addPeriodicTimeObserver : 일정간격으로 시간을 관찰하는 함수
        // - addPeriodicTimeObserver 함수를 timeObserver에 추가
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval:CMTime(seconds: 1, preferredTimescale: 10),queue:DispatchQueue.main, using:{time in
            self.updateTime(time: time)
        })
    }
    
    // 보이기 전에 호출
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTintColor()
        updateTrackInfo()
    }
    
    // 사라지기 전에 호출
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }


    @IBAction func beginDrag(_ sender: UISlider) {
        isSeeking = true
    }
    @IBAction func endDrag(_ sender: UISlider) {
        isSeeking = false
    }
    @IBAction func seek(_ sender: UISlider) {
        // TODO: seeking 구현
        guard let currentItem = simplePlayer.currentItem else { return }
        let position = Double(sender.value)
        let seconds = position * currentItem.duration.seconds
        let time = CMTime(seconds: seconds, preferredTimescale: 100)
        simplePlayer.seek(to: time)
    }
    @IBAction func togglePlayButton(_ sender: Any) {
        // TODO : Playbutton toggle 구현
        if simplePlayer.isPlaying {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        updatePlayButton()
    }
    
}

extension PlayerViewController {
    
    // 재생 멈춤 버튼 업데이트
    func updatePlayButton() {
        if simplePlayer.isPlaying{
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            playControlButton.setImage(image, for: .normal)
        } else {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            playControlButton.setImage(image, for: .normal)
        }
    }
    
    // currentTimeLabel과 durationTimeLabel의 text값 초기화
    func updateTime(time: CMTime) {
        // TODO: 시간정보 업데이트, 심플 플레이어 이용하여 수정
        currentTimeLabel.text = secondToString(sec: simplePlayer.currentTime)
        totalDurationLabel.text = secondToString(sec: simplePlayer.totalDurationTime)
        
        if isSeeking == false {
            // TODO: 슬라이더 정보 업데이트
            timeSlider.value = Float(simplePlayer.currentTime/simplePlayer.totalDurationTime)
        }
    }
    
    // 다크모드 시, Tint 컬러 지정
    func updateTintColor() {
        
    }
    
    // 받아온 item을 가지고 업데이트 = simplePlayer 객체 업데이트
    func updateTrackInfo() {
        guard let track = simplePlayer.currentItem?.convertToTrack() else { return }
        thumbnailImageView.image = track.artwork
        titleLabel.text = track.title
        artistLabel.text = track.artist
        
    }
    
    // 시간 정보(Double형)를 00:00(String형)으로 보여줌
    func secondToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
}
