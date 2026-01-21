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
    let anime: WWAnime
    var body: some View {
        VStack(spacing: 0) {
            WWNavigationBarView(leadingButtonTapped: { dismiss() }, text: "Anime Details", trailingButtonTapped: { showEditView = true })
                .frame(height: 72)
                .padding(.top, 5)
            ScrollView(showsIndicators: false ) {
                VStack(alignment: .leading, spacing: 24) {
                    if let image = anime.image {
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
                        Text(anime.title)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        HStack {
                            Text(anime.status.text)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.vertical, 4).padding(.horizontal, 12)
                                .background(anime.status.bgColor)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            ForEach(Range(0...4), id: \.self) { num in
                                Image(systemName: num < anime.rating ? "star.fill" : "star")
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
                                    Text("Episodes")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundStyle(.textPurple)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(anime.currentEpisode) / \(anime.totalEpisodes)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                WWProgressView(
                                    value: Double(anime.currentEpisode) / Double(anime.totalEpisodes)
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
                                
                                Text("\(hoursMinutes(from: anime.totalTime))")
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
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 16)
                                        
                                        Text("Year")
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .foregroundStyle(.textPurple)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(anime.year)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Total Episodes")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundStyle(.textPurple)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(anime.totalEpisodes)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Episode Duration")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundStyle(.textPurple)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(anime.episodeDuration) min")
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
                        viewModel.delete(anime: anime)
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
            WWEditAnimeView(viewModel: viewModel, anime: anime)
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
        WWAnimeDetailsView(viewModel: WWWatchListViewModel(), anime: WWAnime(
            title: "Attack on Titan",
            year: "2013",
            seasons: 4,
            totalEpisodes: 87,
            episodeDuration: 24,
            status: .watching,
            currentEpisode: 44,
            rating: 2,
            note: "Note asjsadl jaksdjlas jklasdjsajd lasjkdjlkajs ")
                           
        )
    }
}
