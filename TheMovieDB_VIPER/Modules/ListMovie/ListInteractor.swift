//
//  ListInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol ListInteractorInterface: class {
    func fetchUpcomingMovies()
    func fetchNowPlayingMovies()
    func fetchSearchMovies(query: String)
}

protocol MovieListInteractorOutputProtocol: class {
    func upcomingMoviesFetchedSuccessfully(movies: UpcomingMovies)
    func upcomingMoviesFetchingFailed(withError error: Error)
    func nowPlayingMoviesFetchedSuccessfully(movies: NowPlayingMovies)
    func nowPlayingMoviesFetchingFailed(withError error: Error)
    func searchingMoviesFetchedSuccessfully(movies: SearchMovies)
    func searchingMoviesFetchingFailed(withError error: Error)
}

final class ListInteractor {
    weak var output: MovieListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorInterface {
    func fetchSearchMovies(query: String) {
        Worker.shared.searchMovies(query: query) { [weak self] result in
            guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.output?.searchingMoviesFetchedSuccessfully(movies: movies)
                case .failure(let error):
                    self.output?.searchingMoviesFetchingFailed(withError: error)
                    debugPrint("search",error)
            }
        }

    }
    
    func fetchNowPlayingMovies() {
        Worker.shared.getNowPlayingMovies { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let movies):
                self?.output?.nowPlayingMoviesFetchedSuccessfully(movies: movies)
            case .failure(let error):
                debugPrint("nowPlaying",error)
                self?.output?.nowPlayingMoviesFetchingFailed(withError: error)
            }
        }
    }
    
    func fetchUpcomingMovies() {
    
        Worker.shared.getUpcomingMovies { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let movies):
                self?.output?.upcomingMoviesFetchedSuccessfully(movies: movies)
            case .failure(let error):
                debugPrint("upcoming",error)
                self?.output?.upcomingMoviesFetchingFailed(withError: error)
            }
        }
    }
    
}


