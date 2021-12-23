//
//  TrackModel.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 21.12.2021.
//

import Foundation

struct TrackModel: Codable {
    var resultCount: Int
    var results: [Track]
//    var trackName: String
//    var artistName: String
}

struct Track: Codable {
    var artistName: String
    var collectionName: String?
    var trackName: String?
    var artworkUrl100: String?
    var previewUrl: String?
}
