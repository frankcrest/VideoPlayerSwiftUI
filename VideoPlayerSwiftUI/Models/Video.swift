//
//  Video.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import Foundation

struct Video: Decodable {
    let id: String
    let title: String
    let hlsURL: String
    let fullURL: String
    let description: String
    let publishedAt: String
    let author: Author
}
