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
    func searchMovies(query: String)
}

class ListInteractor {
    weak var presenter: MovieListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorInterface {
    func searchMovies(query: String) {
        MovieListWorker.shared.searchMovies(query: query) { [weak self] result in
            guard self != nil else { return }
                switch result {
                case .success(let movies):
                    print(movies)
                case .failure(let error):
                    debugPrint(error)
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
                self?.presenter?.upcomingMoviesFetchingFailed(withError: error)
            }
        }
    }
    
}


