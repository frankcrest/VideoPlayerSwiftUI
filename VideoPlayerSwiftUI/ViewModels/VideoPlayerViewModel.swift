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
    @Published var errorMessage: String = ""
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        fetchVideos()
    }
    
    func fetchVideos() {
        networkManager.fetchVideos { result in
            switch result {
            case .success(let videos):
                self.videos = videos.sorted(by: {$0.publishedAt < $1.publishedAt })
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
}
