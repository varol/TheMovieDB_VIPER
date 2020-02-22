//
//  MovieListWorker.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

class MovieListWorker {
    
    static let shared: MovieListWorker = {
        let instance = MovieListWorker()
        return instance
    }()

    func getUpcomingMovies(completionHandler: @escaping (Results<UpcomingMovies>) -> ()) {
        NetworkManager.shared.request(Router.upcoming, decodeToType: UpcomingMovies.self, completionHandler: completionHandler)
    }
    
    func getNowPlayingMovies(completionHandler: @escaping (Results<NowPlayingMovies>) -> ()) {
        NetworkManager.shared.request(Router.nowPlaying, decodeToType: NowPlayingMovies.self, completionHandler: completionHandler)
    }


}
