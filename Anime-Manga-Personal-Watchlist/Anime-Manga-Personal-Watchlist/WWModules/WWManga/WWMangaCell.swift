//
//  WWAnimeCell.swift
//  Anime-Manga-Personal-Watchlist
//
//  Created by Dias Atudinov on 21.01.2026.
//


import SwiftUI

struct WWAnimeCell: View {
    let anime: WWAnime
    var body: some View {
        HStack(spacing: 16) {
            if let image = anime.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 112)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.imageShimmerBg)
                    .frame(width: 80, height: 112)
                    .overlay {
                        Image(.animeIconWW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                    }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(anime.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text(anime.status.text)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.vertical, 4).padding(.horizontal, 12)
                    .background(anime.status.bgColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Progress")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.secondaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(anime.currentEpisode) / \(anime.totalEpisodes)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                        
                    }
                    
                    WWProgressView(
                        value: Double(anime.currentEpisode) / Double(anime.totalEpisodes)
                    )
                }
                    
            }
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    WWAnimeCell(anime: WWAnime(
        title: "Attack on Titan",
        year: "2013",
        seasons: 4,
        totalEpisodes: 87,
        episodeDuration: 24,
        status: .watching,
        currentEpisode: 44,
        rating: 5,
        note: "Note asjsadl jaksdjlas jklasdjsajd lasjkdjlkajs ")
    )
}