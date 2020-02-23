//
//  MovieDetailsEntity.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    let backdropPath: String?
    let id: Int
    let imdbID: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage, voteCount: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case imdbID = "imdb_id"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}

