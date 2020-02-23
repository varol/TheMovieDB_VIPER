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

protocol MovieDetailInteractorOutputProtocol: class {
    func movieDetailFetchedSuccessfully(details: MovieDetails)
    func movieDetailFetchingFailed(withError error: Error)
    func similarMoviesFetchedSuccessfully(similars: SimilarMovies)
    func similarMoviesFetchingFailed(withError error: Error)
}

final class MovieDetailInteractor {
    weak var output: MovieDetailInteractorOutputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
    func fetchSimilarMovies(movieId: String) {
        DispatchQueue.main.async {
            Worker.shared.similarMovies(movieId: movieId) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let similars):
                    self?.output?.similarMoviesFetchedSuccessfully(similars: similars)
                case .failure(let error):
                    self?.output?.similarMoviesFetchingFailed(withError: error)
                    debugPrint(error)
                }
            }
        }
    }
    
    func fetchMovieDetails(movieId: String) {
        Worker.shared.movieDetail(movieId: movieId) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let details):
                self?.output?.movieDetailFetchedSuccessfully(details: details)
            case .failure(let error):
                self?.output?.movieDetailFetchingFailed(withError: error)
            }
        }
    }
    

}
