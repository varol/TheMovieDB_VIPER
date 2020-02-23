//
//  SimilarMoviesEntity.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 23.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    let page: Int
    let results: [SimilarMoviesResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMoviesResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview, posterPath: String
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
    }
}
