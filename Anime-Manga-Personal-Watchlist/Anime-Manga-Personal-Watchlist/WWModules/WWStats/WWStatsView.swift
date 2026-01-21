//
//  WWStatsView.swift
//  Anime-Manga-Personal-Watchlist
//
//  Created by Dias Atudinov on 21.01.2026.
//

import SwiftUI

struct WWStatsView: View {
    @ObservedObject var viewModel: WWWatchListViewModel
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                OutlinedText(
                    text: "Statistics",
                    font: .system(size: 36, weight: .medium),
                    strokeColor: .textStroke,
                    fillColor: .white
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 8) {
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundStyle(.buttonsTop)
                            
                            Text("Total Time")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 8) {
                                Text("Anime")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(hoursMinutes(from: viewModel.totalWatchedAnimeMinutes()))")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.appBlue)
                            }
                            
                            HStack(spacing: 8) {
                                Text("Manga")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(hoursMinutes(from: viewModel.totalReadMangaMinutes()))")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.buttonsTop)
                            }
                            
                            Rectangle()
                                .fill(.imageShimmerBg)
                                .frame(height: 1)
                            
                            HStack(spacing: 8) {
                                Text("Total")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(hoursMinutes(from: viewModel.totalWatchedAnimeMinutes() + viewModel.totalReadMangaMinutes()))")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.yellow)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 8) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundStyle(.buttonsTop)
                            
                            Text("Progress")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 8) {
                                Text("Completed Anime")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(viewModel.completedAnimeCount())/\(viewModel.animes.count)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.black)
                            }
                            
                            HStack(spacing: 8) {
                                Text("Completed Manga")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(viewModel.completedMangaCount())/\(viewModel.mangas.count)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.black)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 8) {
                            Image(.animeIconWW)
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundStyle(.appBlue)
                            
                            Text("Top Rated Anime")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.topRatedAnime(), id: \.id) { anime in
                                HStack(spacing: 8) {
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(anime.title)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundStyle(.black)
                                        
                                        Text(anime.status.text)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundStyle(.secondaryText)
                                    } .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack {
                                        ForEach(Range(0...4), id: \.self) { num in
                                            Image(systemName: num < anime.rating ? "star.fill" : "star")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 16)
                                                .foregroundStyle(.buttonsTop)
                                                .bold()
                                            
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    
                    VStack(spacing: 16) {
                        HStack(spacing: 8) {
                            Image(systemName: "book")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundStyle(.buttonsTop)
                            
                            Text("Top Rated Manga")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.topRatedManga(), id: \.id) { manga in
                                HStack(spacing: 8) {
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(manga.title)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundStyle(.black)
                                        
                                        Text(manga.status.text)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundStyle(.secondaryText)
                                    } .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack {
                                        ForEach(Range(0...4), id: \.self) { num in
                                            Image(systemName: num < manga.rating ? "star.fill" : "star")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 16)
                                                .foregroundStyle(.buttonsTop)
                                                .bold()
                                            
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    
                }.padding(.bottom, 130)
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.appBgWW)
                .resizable()
                .scaledToFill()
        )
    }
    
    private func hoursMinutes(from totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours) h \(minutes) min"
    }
}

#Preview {
    WWStatsView(viewModel: WWWatchListViewModel())
}
