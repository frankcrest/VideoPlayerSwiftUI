//
//  NetworkManager.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation
import Alamofire

protocol NetworkService {
    func setupURL()
}

class NetworkManager: NetworkService {
    private var url: URL?
    
    init() {
        setupURL()
    }
    
    func fetchVideos() {
        
    }
    
    func setupURL() {
        self.url = URL(string: Constants.videoURLString)
    }
}
