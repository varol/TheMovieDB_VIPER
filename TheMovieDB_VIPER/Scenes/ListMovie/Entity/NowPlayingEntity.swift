//
//  ListEntity.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 21.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

// MARK: - MovieList
struct NowPlayingMovies: Codable {
    let results: [NowPlayingResult]
    let page, totalResults: Int
    let dates: NowPlayingDates
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

// MARK: - Dates
struct NowPlayingDates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct NowPlayingResult: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: NowPlayingOriginalLanguage?
    let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

enum NowPlayingOriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
}


