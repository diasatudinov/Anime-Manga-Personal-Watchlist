//
//  WWProgressView.swift
//  Anime-Manga-Personal-Watchlist
//
//

import SwiftUI

struct WWProgressView: View {
    var value: Double
    var height: CGFloat = 8
    var color: Color = .appBlue
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.progresBarBg)
                
                Capsule()
                    .fill(color)
                    .frame(width: max(0, min(geo.size.width, geo.size.width * value)))
                    
            }
        }
        .frame(height: height)
    }
}

#Preview {
    WWProgressView(value: 0.1)
}
