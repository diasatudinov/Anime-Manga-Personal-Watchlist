//
//  WWEditAnimeView.swift
//  Anime-Manga-Personal-Watchlist
//
//

import SwiftUI

struct WWEditAnimeView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WWWatchListViewModel
    let anime: WWAnime
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    @State private var title: String = ""
    @State private var year = ""
    @State private var seasons = ""
    @State private var totalEpisodes = ""
    @State private var episodeDuration = ""
    @State private var status: ObjectStatus = .watching
    @State private var currentEpisode = ""
    @State private var rating = 0
    @State private var note = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                
                HStack {
                    OutlinedText(
                        text: "Edit Anime",
                        font: .system(size: 24, weight: .semibold),
                        strokeColor: .textStroke,
                        fillColor: .white
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 12)
                            .foregroundStyle(.white)
                            .bold()
                    }
                    
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 166, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay {
                                    Text("Change image")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(.white)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        showingImagePicker = true
                                    }
                                }
                        } else {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.imageShimmerBg)
                                .frame(width: 166, height: 250)
                                .overlay {
                                    Text("Upload image")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(.textPurple)
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(.loadImageBg)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        showingImagePicker = true
                                    }
                                }
                        }
                        
                        VStack(spacing: 16) {
                            textFiled(title: "Title *") {
                                TextField("Enter anime title", text: $title)
                                    .padding(.vertical, 11).padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(alignment: .trailing) {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                            .bold()
                                            .foregroundStyle(.loadImageBg)
                                            .padding()
                                    }
                            }
                            
                            textFiled(title: "Year") {
                                TextField("2026", text: $year)
                                    .padding(.vertical, 11).padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(alignment: .trailing) {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                            .bold()
                                            .foregroundStyle(.loadImageBg)
                                            .padding()
                                    }
                                    .keyboardType(.numberPad)
                            }
                            
                            HStack(spacing: 16) {
                                textFiled(title: "Seasons") {
                                    TextField("1", text: $seasons)
                                        .padding(.vertical, 11).padding(.horizontal, 16)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .overlay(alignment: .trailing) {
                                            Image(systemName: "pencil")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 20)
                                                .bold()
                                                .foregroundStyle(.loadImageBg)
                                                .padding()
                                        }
                                        .keyboardType(.numberPad)
                                }
                                
                                textFiled(title: "Total Episodes") {
                                    TextField("12", text: $totalEpisodes)
                                        .padding(.vertical, 11).padding(.horizontal, 16)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .overlay(alignment: .trailing) {
                                            Image(systemName: "pencil")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 20)
                                                .bold()
                                                .foregroundStyle(.loadImageBg)
                                                .padding()
                                        }
                                        .keyboardType(.numberPad)
                                }
                            }
                            
                            textFiled(title: "Episode Duration (minutes)") {
                                TextField("24", text: $episodeDuration)
                                    .padding(.vertical, 11).padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(alignment: .trailing) {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                            .bold()
                                            .foregroundStyle(.loadImageBg)
                                            .padding()
                                    }
                                    .keyboardType(.numberPad)
                            }
                            
                            textFiled(title: "Total Time (Auto-calculated)") {
                                let totalEpisodes = Double(totalEpisodes) ?? 0.0
                                let episodeDuration = Double(episodeDuration) ?? 0.0
                                Text("\(hoursMinutes(from: Int(totalEpisodes * episodeDuration)))")
                                    .foregroundStyle(.textPurple)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 11).padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                
                            }
                            
                            textFiled(title: "Status") {
                                HStack(spacing: 10) {
                                    ForEach(ObjectStatus.allCases, id: \.self) { status in
                                        Text(status.text)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundStyle(.white)
                                            .padding(.vertical, 4).padding(.horizontal, 12)
                                            .background(status.bgColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .opacity(self.status == status ? 1 : 0.5)
                                            .onTapGesture {
                                                self.status = status
                                            }
                                        
                                    }
                                }
                            }
                            
                            textFiled(title: "Current Episode") {
                                TextField("0", text: $currentEpisode)
                                    .padding(.vertical, 11).padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(alignment: .trailing) {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                            .bold()
                                            .foregroundStyle(.loadImageBg)
                                            .padding()
                                    }
                                    .keyboardType(.numberPad)
                            }
                            
                            textFiled(title: "Rating") {
                                HStack {
                                    ForEach(Range(0...4), id: \.self) { num in
                                        Image(systemName: num < rating ? "star.fill" : "star")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                            .foregroundStyle(.buttonsTop)
                                            .bold()
                                            .onTapGesture {
                                                rating = num + 1
                                            }
                                        
                                    }
                                    
                                    Spacer()
                                }
                            }
                            
                            textFiled(title: "Note") {
                                
                                TextEditor(text: $note)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(height: 120)
                                    .foregroundStyle(.black)
                                    .padding(12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.white)
                                    )
                                    .scrollContentBackground(.hidden)
                                    .overlay(alignment: .topLeading) {
                                        if note.isEmpty {
                                            Text("Text")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundStyle(.secondaryText)
                                                .allowsHitTesting(false)
                                                .padding(15)
                                        }
                                    }
                            }
                        }
                        
                        Button {                            
                            viewModel.editAnime(id: self.anime.id) { a in
                                a.title = title
                                a.year = year
                                a.seasons = Int(seasons) ?? 0
                                a.totalEpisodes = Int(totalEpisodes) ?? 0
                                a.episodeDuration = Int(episodeDuration) ?? 0
                                a.status = status
                                a.currentEpisode = Int(currentEpisode) ?? 0
                                a.rating = rating
                                a.note = note
                                a.imageData = selectedImage?.jpegData(compressionQuality: 0.7)
                            }
                            dismiss()
                        } label: {
                            HStack {
                                Text("Save Changes")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Gradients.brightButton.color)
                            .clipShape( RoundedRectangle(cornerRadius: 20))
                        }.padding(.bottom)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .padding(24)
        .background(Image(.appBgWW).resizable().scaledToFill())
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $showingImagePicker)
        }
        .onAppear {
            
            title = anime.title
            year = anime.year
            seasons = "\(anime.seasons)"
            totalEpisodes = "\(anime.totalEpisodes)"
            episodeDuration = "\(anime.episodeDuration)"
            status = anime.status
            currentEpisode = "\(anime.currentEpisode)"
            rating = anime.rating
            note = anime.note
            selectedImage = anime.image
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
    private func hoursMinutes(from totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours) h \(minutes) min"
    }
    
    @ViewBuilder func textFiled<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8)  {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white)
            
            content()
        }
    }
    
}

#Preview {
    WWEditAnimeView(viewModel: WWWatchListViewModel(),
                    anime:  WWAnime(
                        title: "Attack on Titan",
                        year: "2013",
                        seasons: 4,
                        totalEpisodes: 87,
                        episodeDuration: 24,
                        status: .watching,
                        currentEpisode: 44,
                        rating: 5,
                        note: "Note asjsadl jaksdjlas jklasdjsajd lasjkdjlkajs "))
}
