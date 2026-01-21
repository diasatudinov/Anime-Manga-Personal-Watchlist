//
//  WWAnime.swift
//  Anime-Manga-Personal-Watchlist
//
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

enum ObjectStatus: Codable, CaseIterable {
    case watching
    case completed
    case paused
    case onHold
    
    var text: String {
        switch self {
        case .watching:
            "Watching"
        case .completed:
            "Completed"
        case .paused:
            "Paused"
        case .onHold:
            "On Hold"
        }
    }
    
    var bgColor: Color {
        switch self {
        case .watching:
                .appBlue
        case .completed:
                .appGreen
        case .paused:
                .appRed
        case .onHold:
                .appRed.opacity(0.7)
        }
    }
}
