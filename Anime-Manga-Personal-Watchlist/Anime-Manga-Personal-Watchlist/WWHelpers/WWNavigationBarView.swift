//
//  WWNavigationBarView.swift
//  Anime-Manga-Personal-Watchlist
//
//

import SwiftUI

struct WWNavigationBarView: View {
    let leadingButtonTapped: () -> ()
    let text: String
    let trailingButtonTapped: () -> ()
    var body: some View {
        HStack {
            Button {
                leadingButtonTapped()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(.white)
                    .bold()
            }
            
            OutlinedText(
                text: text,
                font: .system(size: 18, weight: .semibold),
                strokeColor: .textStroke,
                fillColor: .white
            )
            .frame(maxWidth: .infinity)
            
            Button {
                trailingButtonTapped()
            } label: {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundStyle(.buttonsTop)
            }
            
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity)
        .frame(height: 72)
        .background(.navBarBg)
    }
}

#Preview {
    WWNavigationBarView(leadingButtonTapped: {}, text: "Anime Details", trailingButtonTapped: {})
}
