//
//  SimplePlayer.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/13.
//

import AVFoundation

class SimplePlayer {
    // TODO: 싱글톤 만들기, 왜 만드는가?
    // - 앱 내에서 그저 player에서 사용될 item을 교체하기만 하면 되니까 singleton 하나만 있어도 좋다.
    // 싱글톤 객체 : 앱 내에 1개만 존재하며, 필요할 때마다 앱 내 어디든 호출되는 객체
    
    // static 키워드를 통해 SimplePlayer는 싱글톤 객체가 된다. -> 앱 내의 여기저기서 사용 가능한 객체가 됨.
    static let shared = SimplePlayer()
    
    private let player = AVPlayer()
    
    var currentTime: Double {
        // TODO: currentTime 구하기
        return player.currentItem?.currentTime().seconds ?? 0
    }
    
    var totalDurationTime: Double {
        // TODO: totalDurationTime 구하기
        // - total 시간
        return player.currentItem?.duration.seconds ?? 0
    }

    var isPlaying: Bool {
        // TODO: isPlaying 구하기
        // - 재생 중인가?
        
        // isPlaying은 Extension+AVPlayerItem.swift 파일에서 compute property를 extension 했음.
        return player.isPlaying
    }
    
    var currentItem: AVPlayerItem? {
        // TODO: currentItem 구하기
        // - 현재 재생중인 아이템
        return player.currentItem
    }
    
    init() { }
    
    func pause() {
        // TODO: pause구현
        player.pause()
    }
    
    func play() {
        // TODO: play구현
        player.play()
        
    }
    
    func seek(to time:CMTime) {
        // TODO: seek구현
        // - 원하는 시간재생 (by 슬라이더 바)
        player.seek(to: time)
    }
    
    func replaceCurrentItem(with item: AVPlayerItem?) {
        // TODO: replace current item 구현
        // - AVPlayer에서 재생할 곡 선택(바꾸기)
        player.replaceCurrentItem(with: item)
    }
    
    func addPeriodicTimeObserver(forInterval: CMTime, queue: DispatchQueue?, using: @escaping (CMTime) -> Void) {
        player.addPeriodicTimeObserver(forInterval: forInterval, queue: queue, using: using)
    }
    
}
