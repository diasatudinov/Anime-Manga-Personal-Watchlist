//
//  WWMenuView.swift
//  Anime-Manga-Personal-Watchlist
//
//

import SwiftUI

struct WWMenuContainer: View {
    
    @AppStorage("firstOpenBB") var firstOpen: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {
                if firstOpen {
                    WWOnboardingView(getStartBtnTapped: {
                        firstOpen = false
                    })
                } else {
                    WWMenuView()
                }
            }
        }
    }
}

struct WWMenuView: View {
    @State var selectedTab = 0
    @StateObject var watchlistViewModel = WWWatchListViewModel()
    private let tabs = ["My dives", "Calendar", "Stats"]
        
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                WWAnimeView(viewModel: watchlistViewModel)
            case 1:
                WWMangaView(viewModel: watchlistViewModel)
            case 2:
                WWStatsView(viewModel: watchlistViewModel)
            default:
                Text("default")
            }
            VStack {
                Spacer()
                
                HStack(spacing: 45) {
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack {
                                Image(icon(for: index))
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(selectedTab == index ? .white : .tabRed)
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text(text(for: index))
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(selectedTab == index ? .white : .tabRed)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                selectedTab == index ? Color.selectedPink : .tabBg
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            
                        }
                        
                    }
                }
                .padding(.vertical, 13)
                .frame(maxWidth: .infinity)
                .background(.tabBg)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
            }.padding(.bottom, 40)
            .ignoresSafeArea()
                
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tabIcon1WW"
        case 1: return "tabIcon2WW"
        case 2: return "tabIcon3WW"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelected"
        case 1: return "tab2IconSelected"
        case 2: return "tab3IconSelected"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Anime"
        case 1: return "Manga"
        case 2: return "Stats"
        default: return ""
        }
    }
}

#Preview {
    WWMenuContainer()
}
