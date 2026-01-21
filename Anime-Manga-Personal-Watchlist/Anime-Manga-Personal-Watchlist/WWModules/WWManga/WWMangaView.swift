//
//  WWMangaView.swift
//  Anime-Manga-Personal-Watchlist
//
//


import SwiftUI

struct WWMangaView: View {
    @ObservedObject var viewModel: WWWatchListViewModel
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                OutlinedText(
                    text: "My Manga",
                    font: .system(size: 36, weight: .medium),
                    strokeColor: .textStroke,
                    fillColor: .white
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(viewModel.mangas.count) titles")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(viewModel.mangas, id: \.id) { manga in
                        NavigationLink {
                            WWMangaDetailsView(viewModel: viewModel, manga: manga)
                                .navigationBarBackButtonHidden()
                        } label: {
                            WWMangaCell(manga: manga)
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
                WWNewMangaView(viewModel: viewModel)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                    
                    Text("Add Manga")
                        .font(.system(size: 16, weight: .medium))
                        
                }
                .foregroundStyle(.white)
                .padding(16)
                .background(Gradients.brightButton.color)
                .clipShape( RoundedRectangle(cornerRadius: 20))
                
            }
            .padding(24)
            .padding(.bottom, 130)
        }
    }
}

#Preview {
    NavigationStack {
        WWMangaView(viewModel: WWWatchListViewModel())
    }
}
