//
//  AVPlayerController+Extension.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation
import AVKit

extension AVPlayerViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.showsPlaybackControls = false
    }
}
