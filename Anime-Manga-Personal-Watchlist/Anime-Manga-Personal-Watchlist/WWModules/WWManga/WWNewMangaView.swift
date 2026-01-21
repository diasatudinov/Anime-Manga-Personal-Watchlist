//
//  WWNewMangaView.swift
//  Anime-Manga-Personal-Watchlist
//
//


import SwiftUI

struct WWNewMangaView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WWWatchListViewModel

    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    @State private var title: String = ""
    @State private var totalVolumes = ""
    @State private var pagePerVolume = ""
    @State private var readingSpeed = ""
    @State private var status: ObjectStatus = .watching
    @State private var currentVolume = ""
    @State private var currentPage = ""
    @State private var rating = 0
    @State private var note = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                
                HStack {
                    OutlinedText(
                        text: "Add Manga",
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
                                TextField("Enter manga title", text: $title)
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
                            
                            HStack(spacing: 16) {
                                textFiled(title: "Total Volumes") {
                                    TextField("1", text: $totalVolumes)
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
                                
                                textFiled(title: "Pages per Volume") {
                                    TextField("200", text: $pagePerVolume)
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
                            
                            textFiled(title: "Total Pages (Auto-calculated)") {
                                let totalVolumes = Double(totalVolumes) ?? 0.0
                                let pagePerVolume = Double(pagePerVolume) ?? 0.0
                                
                                Text("\(Int(totalVolumes * pagePerVolume))")
                                    .foregroundStyle(.textPurple)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 11).padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                
                            }
                            
                            textFiled(title: "Reading Speed (pages per minute)") {
                                TextField("2", text: $readingSpeed)
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
                            
                            textFiled(title: "Total Reading Time (Auto-calculated)") {
                                let totalVolumes = Double(totalVolumes) ?? 0.0
                                let pagePerVolume = Double(pagePerVolume) ?? 0.0
                                let readingSpeed = max(1.0, Double(readingSpeed) ?? 1.0)
                                
                                let totalReadingTime = (totalVolumes * pagePerVolume) / readingSpeed
                                
                                Text("\(hoursMinutes(from: Int(totalReadingTime)))")
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
                            
                            textFiled(title: "Current Volume") {
                                TextField("0", text: $currentVolume)
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
                            
                            textFiled(title: "Current Page") {
                                TextField("0", text: $currentPage)
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
                            let manga = WWManga(
                                title: title,
                                totalVolumes: Int(totalVolumes) ?? 0,
                                pagePerVolume: Int(pagePerVolume) ?? 0,
                                readingSpeed: Int(readingSpeed) ?? 1,
                                status: status,
                                currentVolume: Int(currentVolume) ?? 0,
                                currentPage: Int(currentPage) ?? 0,
                                rating: rating,
                                note: note,
                                imageData: selectedImage?.jpegData(compressionQuality: 0.7)
                            )
                            
                            viewModel.add(manga: manga)
                            dismiss()
                        } label: {
                            HStack {
                                
                                Text("Add Manga")
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
    WWNewMangaView(viewModel: WWWatchListViewModel())
}
