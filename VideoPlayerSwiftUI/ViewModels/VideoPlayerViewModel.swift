//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation
import AVKit

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer = AVPlayer()
    @Published var isPlaying: Bool = false
    @Published var videos: [Video] = []
    private var playerItems: [AVPlayerItem] = []
    private let networkManager: NetworkService
    @Published var currentIndex = 0
    @Published var errorMessage: String = ""
    var disablePreviousButton: Bool {
        shouldDisablePreviousButton()
    }
    var disableNextButton: Bool {
        shouldDisableNextButton()
    }
    var currentVideo: Video {
        videos[currentIndex]
    }
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        fetchVideos()
    }
    
    private func fetchVideos() {
        networkManager.fetchVideos { result in
            switch result {
            case .success(let videos):
                self.videos = videos.sorted(by: { $0.publishedAt < $1.publishedAt })
                self.setupPlayer()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func setupPlayer() {
        let playerItems: [AVPlayerItem] = videos.compactMap { video in
            if let hlsURL = URL(string: video.hlsURL) {
                return AVPlayerItem(url: hlsURL)
            } else if let fullURL = URL(string: video.fullURL) {
                return AVPlayerItem(url: fullURL)
            } else {
                return nil
            }
        }
        
        self.playerItems = playerItems
        player = AVPlayer(playerItem: playerItems.first)
    }
    
    func playPause() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func previous() {
        guard currentIndex > 0 else {
            return
        }
        
        currentIndex -= 1
        
        playTrack()
    }
    
    func next() {
        guard currentIndex < playerItems.count - 1 else {
            return
        }
        
        currentIndex += 1
        
        playTrack()
    }
    
    private func playTrack() {
        if playerItems.count > 0 {
            pause()
            player.seek(to: CMTime.zero)
            player.replaceCurrentItem(with: playerItems[currentIndex])
        }
    }
    
    private func shouldDisablePreviousButton() -> Bool {
       return currentIndex == 0

    }
    
    private func shouldDisableNextButton() -> Bool {
        return currentIndex == playerItems.count - 1
    }
    
}
