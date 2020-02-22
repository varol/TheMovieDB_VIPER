//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInterface: class {
    func fetchMovieDetails(movieId: String)
    func fetchSimilarMovies(movieId: String)
}

class MovieDetailInteractor {
    weak var presenter: MovieDetailInteractorOutputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
    func fetchSimilarMovies(movieId: String) {
        MovieListWorker.shared.similarMovies(movieId: movieId) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let similars):
                self?.presenter?.similarMoviesFetchedSuccessfully(similars: similars)
                print(similars)
            case .failure(let error):
                self?.presenter?.similarMoviesFetchingFailed(withError: error)
                print(error)
            }

        }
    }
    
    func fetchMovieDetails(movieId: String) {
        MovieListWorker.shared.movieDetail(movieId: movieId) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let details):
                self?.presenter?.movieDetailFetchedSuccessfully(details: details)
            case .failure(let error):
                self?.presenter?.movieDetailFetchingFailed(withError: error)
                print(error)
            }

        }
    }
    

}
