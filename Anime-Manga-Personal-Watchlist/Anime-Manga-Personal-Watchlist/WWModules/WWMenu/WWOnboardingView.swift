//
//  WWOnboardingView.swift
//  Anime-Manga-Personal-Watchlist
//
//

import SwiftUI

struct WWOnboardingView: View {
var getStartBtnTapped: () -> ()
    @State var count = 0
    
    var onbImage: Image {
        switch count {
        case 0:
            Image(.onboardingImg1WW)
        case 1:
            Image(.onboardingImg2WW)
        case 2:
            Image(.onboardingImg3WW)
        default:
            Image(.onboardingImg1WW)
        }
    }
    
    var onbTitle: String {
        switch count {
        case 0:
            "Add your favorite anime and manga"
        case 1:
            "Track progress automatically"
        case 2:
            "See your personal statistics"
        default:
            "Record Every Dive"
        }
    }
    
    var onbDescription: String {
        switch count {
        case 0:
            "Create your personal list of anime and manga.\nAdd seasons, episodes, volumes, and pages — everything in one place."
        case 1:
            "See your progress at a glance.\nThe app calculates total time, pages read, and completion percentage for you."
        case 2:
            "Check how much time you've spent watching anime and reading manga.\nEverything stays on your device — no accounts, no internet."
        default:
            "Save your depth, duration, photos, emotions, and locations - build your personal underwater story."
        }
    }
    
    var body: some View {
        VStack {
            
            if count != 2 {
                Button {
                    getStartBtnTapped()
                } label: {
                    Text("Skip")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 32)
            } else {
                Text("Skip")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                    .opacity(0)
            }
            onbImage
                .resizable()
                .scaledToFit()
            VStack(spacing: 16) {
                Text(onbTitle)
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                
                Text(onbDescription)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 8)
                
                if count != 0 {
                    additionalInformationsView()
                }
                
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .shadow(color: .black.opacity(0.7), radius: 1, x: 0, y: 4)
            Spacer()
            
            VStack {
                
                HStack {
                    if count == 0 {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 32, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Circle()
                            .fill(.dotOff)
                            .frame(width: 10, height: 10)
                    }
                    
                    
                    if count == 1 {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 32, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Circle()
                            .fill(.dotOff)
                            .frame(width: 10, height: 10)
                    }
                    
                    if count == 2 {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 32, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Circle()
                            .fill(.dotOff)
                            .frame(width: 10, height: 10)
                    }
                }
                
                Button {
                    if count < 2 {
                        withAnimation {
                            count += 1
                        }
                    } else {
                        getStartBtnTapped()
                    }
                } label: {
                    Text(count < 2 ? "Next" : "Get Started")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Gradients.buttons.color)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .shadow(color: .shadow, radius: 3.7, x: 0, y: 4)
                        .padding(.horizontal, 32)
                }
            }.padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Image(.onboardingBgWW)
                .resizable()
                .ignoresSafeArea()
        )
    }
    
    @ViewBuilder func additionalInformationsView() -> some View {
        switch count {
        case 0:
            VStack(alignment: .leading, spacing: 8) {
                additionalInfoCell(text: "Episode & page progress") {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.appBlue)
                }
                
                additionalInfoCell(text: "Total time spent") {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.appYellow)
                }
                
                additionalInfoCell(text: "Clear status: Watching, Reading, Completed, Paused") {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.appGreen)
                }
                
            }
        case 1:
            VStack(alignment: .leading, spacing: 8) {
                additionalInfoCell(text: "Episode & page progress") {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.appBlue)
                }
                
                additionalInfoCell(text: "Total time spent") {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.appYellow)
                }
                
                additionalInfoCell(text: "Clear status: Watching, Reading, Completed, Paused") {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.appGreen)
                }
                
            }
        case 2:
            VStack(alignment: .center, spacing: 8) {
                additionalInfoCell(text: "✨ Monthly & yearly stats") {
                }
                
                additionalInfoCell(text: "⭐ Top rated titles") {
                }
                
                additionalInfoCell(text: "📱 Fully offline") {
                }
                
            }
        default:
            VStack {
                additionalInfoCell(text: "") {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.blue)
                }
            }
        }
            
        VStack {
            
        }
    }
    
    private func additionalInfoCell<Content: View>(
            text: String,
            @ViewBuilder content: () -> Content
        ) -> some View {
            HStack(alignment: .center, spacing: 8) {
                content()
                
                Text(text)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    
}

#Preview {
    WWOnboardingView(getStartBtnTapped: { })
}

