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

class ListInteractor {
    weak var presenter: MovieListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorInterface {
    func fetchSearchMovies(query: String) {
        MovieListWorker.shared.searchMovies(query: query) { [weak self] result in
            guard self != nil else { return }
                switch result {
                case .success(let movies):
                    self?.presenter?.searchingMoviesFetchedSuccessfully(movies: movies)
                case .failure(let error):
                    self?.presenter?.searchingMoviesFetchingFailed(withError: error)
                    debugPrint("search",error)
            }
        }

    }
    
    func fetchNowPlayingMovies() {
        MovieListWorker.shared.getNowPlayingMovies { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let movies):
                self?.presenter?.nowPlayingMoviesFetchedSuccessfully(movies: movies)
            case .failure(let error):
                debugPrint("now",error)

                self?.presenter?.nowPlayingMoviesFetchingFailed(withError: error)
            }
        }
    }
    
    func fetchUpcomingMovies() {
    
        MovieListWorker.shared.getUpcomingMovies { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let movies):
                self?.presenter?.upcomingMoviesFetchedSuccessfully(movies: movies)
            case .failure(let error):
                debugPrint("upcom",error)

                self?.presenter?.upcomingMoviesFetchingFailed(withError: error)
            }
        }
    }
    
}


