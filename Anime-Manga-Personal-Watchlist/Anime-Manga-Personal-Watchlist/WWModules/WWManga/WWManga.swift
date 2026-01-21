//
//  WWManga.swift
//  Anime-Manga-Personal-Watchlist
//
//


import SwiftUI

struct WWManga: Codable, Hashable, Identifiable {
    let id = UUID()
    var title: String
    var totalVolumes: Int
    var pagePerVolume: Int
    var readingSpeed: Int
    var status: ObjectStatus
    var currentVolume: Int
    var currentPage: Int
    var rating: Int
    var note: String
    
    var totalPages: Int {
        return totalVolumes * pagePerVolume
    }
    
    var totalReadingTime: Int {
        return totalPages / readingSpeed
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
