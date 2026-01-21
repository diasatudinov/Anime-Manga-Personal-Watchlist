//
//  WWAnime.swift
//  Anime-Manga-Personal-Watchlist
//
//  Created by Dias Atudinov on 21.01.2026.
//


import SwiftUI

struct WWAnime: Codable, Hashable, Identifiable {
    let id = UUID()
    var title: String
    var year: String
    var seasons: Int
    var totalEpisodes: Int
    var episodeDuration: Int
    var status: ObjectStatus
    var currentEpisode: Int
    var rating: Int
    var note: String
    
    var totalTime: Int {
        return totalEpisodes * episodeDuration
    }
    
    var imageData: Data?
    
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    
}