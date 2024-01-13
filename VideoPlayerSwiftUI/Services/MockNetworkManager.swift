//
//  MockNetworkManager.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation
import Alamofire

class MockNetworkManager: NetworkService {
    func fetchVideos(completion: @escaping (Result<[Video], Alamofire.AFError>) -> Void) {
        let videos = [
            Video(id: "123", title: "title", hlsURL: "https://www.google.com", fullURL: "https://www.google.com", description: "Lorem ipsum", publishedAt: Date.now, author: Author(id: "123", name: "unknown")),
            Video(id: "456", title: "title2", hlsURL: "https://www.google.com", fullURL: "https://www.google.com", description: "Ipsum Lorem", publishedAt: Date.now, author: Author(id: "456", name: "known"))
        ]
        completion(.success(videos))
    }
    
    private var url: URL?
    
    func setupURL() {
        self.url = URL(string: "https://www.google.com")
    }
    
    
}
