//
//  UpcomingEntity.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation
// MARK: - UpcomingMovies
struct UpcomingMovies: Codable {
    let results: [UpcomingResult]
    let page, totalResults: Int
    let dates: UpcomingDates
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

// MARK: - Dates
struct UpcomingDates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct UpcomingResult: Codable {
    let video: Bool
    let posterPath: String
    let id: Int
    let backdropPath: String?
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case video
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
