//
//  Worker.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

class Worker {
    
    static let shared: Worker = {
        let instance = Worker()
        return instance
    }()

    func getUpcomingMovies(completionHandler: @escaping (Results<UpcomingMovies>) -> ()) {
        NetworkManager.shared.request(Router.upcoming, decodeToType: UpcomingMovies.self, completionHandler: completionHandler)
    }
    
    func getNowPlayingMovies(completionHandler: @escaping (Results<NowPlayingMovies>) -> ()) {
        NetworkManager.shared.request(Router.nowPlaying, decodeToType: NowPlayingMovies.self, completionHandler: completionHandler)
    }

    func searchMovies(query:String, completionHandler: @escaping (Results<SearchMovies>) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: SearchMovies.self, completionHandler: completionHandler)
    }

    func movieDetail(movieId: String, completionHandler: @escaping (Results<MovieDetails>) -> ()) {
        NetworkManager.shared.request(Router.details(movieId: movieId), decodeToType: MovieDetails.self, completionHandler: completionHandler)
    }

    func similarMovies(movieId: String, completionHandler: @escaping (Results<SimilarMovies>) -> ()) {
        NetworkManager.shared.request(Router.similars(movieId: movieId), decodeToType: SimilarMovies.self, completionHandler: completionHandler)
    }
}
