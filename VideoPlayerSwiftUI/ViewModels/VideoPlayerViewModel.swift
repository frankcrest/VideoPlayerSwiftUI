//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation
import AVKit

class VideoPlayerViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var player: AVPlayer = AVPlayer()
    @Published var isPlaying: Bool = false
    @Published var videos: [Video] = []
    @Published var currentIndex = 0
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    private var playerItems: [AVPlayerItem] = []
    private let networkManager: NetworkService
    
    var disablePreviousButton: Bool {
        shouldDisablePreviousButton()
    }
    var disableNextButton: Bool {
        shouldDisableNextButton()
    }
    var currentVideo: Video {
        videos[currentIndex]
    }
    
    // MARK: - Initialization
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        fetchVideos()
    }
    
    // MARK: - Methods
    
    private func fetchVideos() {
        isLoading = true
        networkManager.fetchVideos { result in
            switch result {
            case .success(let videos):
                self.videos = videos.sorted(by: { $0.publishedAt < $1.publishedAt })
                self.setupPlayer()
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showAlert = true
                self.isLoading = false
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
    
    // MARK: - Actions
    
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
    
}
