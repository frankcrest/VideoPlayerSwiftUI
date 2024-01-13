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
}