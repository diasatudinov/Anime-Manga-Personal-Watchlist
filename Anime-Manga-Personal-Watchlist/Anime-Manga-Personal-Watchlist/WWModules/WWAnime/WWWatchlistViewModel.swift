//
//  WWWatchlistViewModel.swift
//  Anime-Manga-Personal-Watchlist
//
//

import SwiftUI

final class WWWatchListViewModel: ObservableObject {
    // MARK: – Anime
    @Published var animes: [WWAnime] = [
        
    ] {
        didSet {
            saveAnimes()
        }
    }
    
    @Published var mangas: [WWManga] = [
        
    ] {
        didSet {
            saveMangas()
        }
    }
    
    // MARK: – UserDefaults keys
    private var animeFileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("animes.json")
    }
    
    private var mangaFileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("manga.json")
    }
    
    // MARK: – Init
    init() {
        loadAnimes()
        loadMangas()
    }
    
    // MARK: – Save / Load Backgrounds
    
    private func saveAnimes() {
        let url = animeFileURL
        do {
            let data = try JSONEncoder().encode(animes)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadAnimes() {
        let url = animeFileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let animesData = try JSONDecoder().decode([WWAnime].self, from: data)
            animes = animesData
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    // MARK: – Example buy action
    func add(anime: WWAnime) {
        guard !animes.contains(anime) else { return }
        animes.append(anime)
    }
    
    func delete(anime: WWAnime) {
        guard let index = animes.firstIndex(of: anime) else { return }
        animes.remove(at: index)
    }
    
    func editAnime(id: WWAnime.ID, _ mutate: (inout WWAnime) -> Void) {
        guard let index = animes.firstIndex(where: { $0.id == id }) else { return }
        mutate(&animes[index])
    }
    
    private func saveMangas() {
        let url = mangaFileURL
        do {
            let data = try JSONEncoder().encode(mangas)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadMangas() {
        let url = mangaFileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let animesData = try JSONDecoder().decode([WWManga].self, from: data)
            mangas = animesData
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    // MARK: – Example buy action
    func add(manga: WWManga) {
        guard !mangas.contains(manga) else { return }
        mangas.append(manga)
    }
    
    func delete(manga: WWManga) {
        guard let index = mangas.firstIndex(of: manga) else { return }
        mangas.remove(at: index)
    }
    
    func editManga(id: WWManga.ID, _ mutate: (inout WWManga) -> Void) {
        guard let index = mangas.firstIndex(where: { $0.id == id }) else { return }
        mutate(&mangas[index])
    }
    
    // MARK: Total
    
    func totalWatchedAnimeMinutes() -> Int {
        animes.reduce(0) { sum, anime in
            let watchedEpisodes = max(0, min(anime.currentEpisode, anime.totalEpisodes))
            return sum + watchedEpisodes * anime.episodeDuration
        }
    }
    
    private func readMinutes(for manga: WWManga) -> Int {
        // ⚠️ замени поля на свои реальные названия
        let totalPages = max(0, manga.totalVolumes * manga.pagePerVolume)
        
        let readPagesRaw = max(0, manga.currentVolume * manga.pagePerVolume + manga.currentPage)
        let readPages = min(readPagesRaw, totalPages)
        
        let speed = max(1, manga.readingSpeed) // pages/min, минимум 1 чтобы не делить на 0
        
        return readPages / speed
    }
    
    func totalReadMangaMinutes() -> Int {
        mangas.reduce(0) { sum, manga in
            sum + readMinutes(for: manga)
        }
    }
    
    func completedAnimeCount() -> Int {
        animes.filter { $0.status == .completed }.count
    }
    
    func completedMangaCount() -> Int {
        mangas.filter { $0.status == .completed }.count
    }
    
    func topRatedAnime(limit: Int = 3) -> [WWAnime] {
        animes
            .sorted {
                if $0.rating != $1.rating { return $0.rating > $1.rating }
                return $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }
            .prefix(limit)
            .map { $0 }
    }
    
    func topRatedManga(limit: Int = 3) -> [WWManga] {
        mangas
            .sorted {
                if $0.rating != $1.rating { return $0.rating > $1.rating }
                return $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }
            .prefix(limit)
            .map { $0 }
    }
    
}
