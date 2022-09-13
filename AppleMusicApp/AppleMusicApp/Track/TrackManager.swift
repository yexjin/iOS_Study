//
//  TrackManager.swift
//  AppleMusicApp
//
//  Created by 오예진 on 2022/09/12.
//

import UIKit
import AVFoundation
//  AVFoundation : Apple플랫폼에서 시청각(audiovisual) 미디어를 캡쳐, 처리, 합성, 가져오기(import), 내보내기(export)를 하는 다양한 작업을 포함한 4개의 주요 기술 영역을 결합한 프레임워크

class TrackManager {
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todayMusic: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todayMusic = self.tracks.randomElement()
    }
    
    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        // 파일을 읽어서 AVPlayerItem 만들기
        
        //urls 는 Bundle(이 앱).main(메인).urls
        //urls는 URL 배열 타입
        //urls() : url을 가져오기 위해 제공해주는 메소드
        // - 확장자, 하위폴더
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
    
        let items = urls.map { url in
            return AVPlayerItem(url: url)
        }
        
        return items    // array 형태로 반환
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        // 여기서 가져온 playerItem은 타입이 AVPlayerItem
        
        let track = playerItem.convertToTrack()
        // convertToTrack : Track 타입으로 변경시키기 위한 함수
        // 이 'convertToTrack' 함수는 Extension+AVPlayerItem 파일에 정의
        return track
    }
    
    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        
        // tracks는 현재 AVPlayItem의 array이며, 이안에 존재하는 item들의 타입들을 Track으로 변경
        let trackList: [Track] = tracks.compactMap { track in track.convertToTrack() }
        
        // albumDics : albumName(key)을 기준으로 딕셔너리 만들기
        // - key : albumName
        // - value: trackList 안의 albumName가 같은 모든 track들
        let albumDics = Dictionary(grouping: trackList) { track in track.albumName }
        
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        
        return albums
    }
    
    // TODO: 오늘의 트랙이 랜덤으로 선택되게 하는 함수
    // - 헤더로 사용할..
    func loadOtherTodaysTrack(){
        self.todayMusic = self.tracks.randomElement()
    }
 }


