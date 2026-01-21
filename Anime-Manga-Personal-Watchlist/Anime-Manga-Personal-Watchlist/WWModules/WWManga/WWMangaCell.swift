//
//  WWMangaCell.swift
//  Anime-Manga-Personal-Watchlist
//
//


import SwiftUI

struct WWMangaCell: View {
    let manga: WWManga
    var body: some View {
        HStack(spacing: 16) {
            if let image = manga.image {
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
                        Image(.mangaIconWW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                    }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(manga.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text(manga.status.text)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.vertical, 4).padding(.horizontal, 12)
                    .background(manga.status.bgColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Volume")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.secondaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(manga.currentVolume) / \(manga.totalVolumes)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                        
                    }
                    
                    WWProgressView(
                        value: Double(manga.currentVolume) / Double(manga.totalVolumes),
                        color: .buttonsTop
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
    WWMangaCell(manga: WWManga(
        title: "Berserk",
        totalVolumes: 41,
        pagePerVolume: 230,
        readingSpeed: 2,
        status: .paused,
        currentVolume: 30,
        currentPage: 6900,
        rating: 4,
        note: "Note",
        imageData: nil)
    )
}
