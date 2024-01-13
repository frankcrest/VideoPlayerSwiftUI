//
//  NetworkManager.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation
import Alamofire

protocol NetworkService {

}

class NetworkManager {
    private let url: URL
    
    init?(url: String) {
        guard let url = URL(string: url) else {
            return nil
        }
        
        self.url = url
    }
    
    func fetchVideos() {
        
    }
}
