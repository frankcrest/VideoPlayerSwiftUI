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
    func fetchVideos(completion: @escaping(Result<[Video], AFError>) -> Void)
}

class NetworkManager: NetworkService {
    
    // MARK: - Properties
    
    private var url: URL?
    
    // MARK: - Initialization
    
    init() {
        setupURL()
    }
    
    // MARK: - Methods
    
    func fetchVideos(completion: @escaping(Result<[Video], AFError>) -> Void) {
        guard let url = url else {
            completion(.failure(AFError.invalidURL(url: Constants.videoURLString)))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        AF.request(url).responseDecodable(of: [Video].self, decoder: decoder) { response in
            switch response.result {
            case .success(let videos):
                completion(.success(videos))
            case .failure(let afError):
                completion(.failure(afError))
            }
        }
    }
    
    func setupURL() {
        self.url = URL(string: Constants.videoURLString)
    }
}
