//
//  WWMangaDetailsView.swift
//  Anime-Manga-Personal-Watchlist
//
//  Created by Dias Atudinov on 21.01.2026.
//


import SwiftUI

struct WWMangaDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WWWatchListViewModel
    @State private var showEditView = false
    let manga: WWManga
    var body: some View {
        VStack(spacing: 0) {
            WWNavigationBarView(leadingButtonTapped: { dismiss() }, text: "Manga Details", trailingButtonTapped: { showEditView = true })
                .frame(height: 72)
                .padding(.top, 5)
            ScrollView(showsIndicators: false ) {
                VStack(alignment: .leading, spacing: 24) {
                    if let image = manga.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 167, height: 256)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.imageShimmerBg)
                            .frame(width: 167, height: 256)
                            .overlay {
                                Image(.animeIconWW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 32)
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(manga.title)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        HStack {
                            Text(manga.status.text)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.vertical, 4).padding(.horizontal, 12)
                                .background(manga.status.bgColor)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            ForEach(Range(0...4), id: \.self) { num in
                                Image(systemName: num < manga.rating ? "star.fill" : "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                    .foregroundStyle(.buttonsTop)
                                    .bold()
                                
                                
                            }
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(spacing: 15) {
                            Text("Progress")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    Text("Volumes")
                                        .font(.system(size: 14, weight: .regular))
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
                            
                            VStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    Text("Pages")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.secondaryText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(manga.currentPage) / \(manga.totalPages)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                WWProgressView(
                                    value: Double(manga.currentVolume) / Double(manga.totalVolumes),
                                    color: .buttonsTop
                                )
                            }
                            
                            Rectangle()
                                .fill(.imageShimmerBg)
                                .frame(height: 1)
                            
                            HStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    Image(systemName: "clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 16)
                                    
                                    Text("Total Time")
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .foregroundStyle(.textPurple)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(hoursMinutes(from: manga.totalReadingTime))")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.yellow)
                            }
                            
                        }
                        .padding(16)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        VStack(spacing: 16) {
                            Text("Details")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(spacing: 12) {
                                HStack(spacing: 0) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "book")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 16)
                                        
                                        Text("Total Volumes")
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .foregroundStyle(.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(manga.totalVolumes)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                HStack(spacing: 0) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "doc.text")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 16)
                                        
                                        Text("Pages per Volume")
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .foregroundStyle(.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(manga.pagePerVolume)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Total Pages")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.secondaryText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(manga.totalPages)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Reading Speed")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.secondaryText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(manga.readingSpeed) pages/min")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                            }
                            
                        }
                        .padding(16)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                    }
                    
                    Button {
                        viewModel.delete(manga: manga)
                        dismiss()
                    } label: {
                        HStack {
                            
                            Text("Delete")
                                .font(.system(size: 16, weight: .medium))
                            
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Gradients.brightButton.color)
                        .clipShape( RoundedRectangle(cornerRadius: 20))
                    }.padding(.bottom)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
            }
        }
        .background(
            Image(.appBgWW)
                .resizable()
                .scaledToFill()
        )
        .navigationDestination(isPresented: $showEditView) {
            WWEditMangaView(viewModel: viewModel, manga: manga)
                .navigationBarBackButtonHidden()
        }
    }
    
    private func hoursMinutes(from totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours) h \(minutes) min"
    }
}

#Preview {
    NavigationStack {
        WWMangaDetailsView(viewModel: WWWatchListViewModel(), manga:
                            WWManga(
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
}
