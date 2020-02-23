//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: class {
    func fetchDetails(movieId: String)
    func fetchSimilars(movieId: String)
}

final class MovieDetailPresenter {

    unowned var view: MovieDetailViewControllerInterface
    let router: MovieDetailRouterInterface?
    let interactor: MovieDetailInteractorInterface?
    
    init(interactor: MovieDetailInteractorInterface, router: MovieDetailRouterInterface, view: MovieDetailViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func fetchDetails(movieId: String) {
        self.interactor?.fetchMovieDetails(movieId: movieId)
    }
    
    func fetchSimilars(movieId: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchSimilarMovies(movieId: movieId)
        }
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    
    func similarMoviesFetchedSuccessfully(similars: SimilarMovies) {
        view.loadSimilarMovies(similarMovies: similars)
    }
    
    func similarMoviesFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
    
    func movieDetailFetchedSuccessfully(details: MovieDetails) {
        view.prepareMovieDetail(movieDetail: details)
    }
    
    func movieDetailFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
}
