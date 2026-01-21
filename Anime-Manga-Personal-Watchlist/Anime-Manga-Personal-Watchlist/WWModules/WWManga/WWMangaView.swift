//
//  WWAnimeView.swift
//  Anime-Manga-Personal-Watchlist
//
//  Created by Dias Atudinov on 21.01.2026.
//


import SwiftUI

struct WWAnimeView: View {
    @ObservedObject var viewModel: WWWatchListViewModel
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                OutlinedText(
                    text: "My Anime",
                    font: .system(size: 36, weight: .medium),
                    strokeColor: .textStroke,
                    fillColor: .white
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(viewModel.animes.count) titles")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(viewModel.animes, id: \.id) { anime in
                        NavigationLink {
                            WWAnimeDetailsView(viewModel: viewModel, anime: anime)
                                .navigationBarBackButtonHidden()
                        } label: {
                            WWAnimeCell(anime: anime)
                        }
                    }
                }.padding(.bottom, 100)
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.appBgWW)
                .resizable()
                .scaledToFill()
        )
        .overlay(alignment: .bottomTrailing) {
            NavigationLink {
                WWNewAnimeView(viewModel: viewModel)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                    
                    Text("Add Anime")
                        .font(.system(size: 16, weight: .medium))
                        
                }
                .foregroundStyle(.white)
                .padding(16)
                .background(Gradients.brightButton.color)
                .clipShape( RoundedRectangle(cornerRadius: 20))
                
            }
            .padding(24)
            .padding(.bottom, 105)
        }
    }
}

#Preview {
    NavigationStack {
        WWAnimeView(viewModel: WWWatchListViewModel())
    }
}