//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: class {
    func viewDidAppear()
    func getMovieDetails() -> MovieDetails?
    func getSimilarMovies() -> SimilarMovies?
    func fetchDetails(movieId: String)
    func fetchSimilars(movieId: String)
}

protocol MovieDetailInteractorOutputProtocol: class {
    func movieDetailFetchedSuccessfully(details: MovieDetails)
    func movieDetailFetchingFailed(withError error: Error)
    func similarMoviesFetchedSuccessfully(similars: SimilarMovies)
    func similarMoviesFetchingFailed(withError error: Error)
}

class MovieDetailPresenter {

    unowned var view: MovieDetailViewControllerInterface
    let router: MovieDetailRouterInterface?
    let interactor: MovieDetailInteractorInterface?
    
    var movieDetail = [MovieDetails]()
    var similarMovies = [SimilarMovies]()

    init(interactor: MovieDetailInteractorInterface, router: MovieDetailRouterInterface, view: MovieDetailViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface, MovieDetailInteractorOutputProtocol {
    
    
    func getMovieDetails() -> MovieDetails? {
        return movieDetail.first
    }

    func getSimilarMovies() -> SimilarMovies? {
        similarMovies.first
    }
    
    func similarMoviesFetchedSuccessfully(similars: SimilarMovies) {
        similarMovies.append(similars)
        view.loadSimilarMovies()

    }
    
    func similarMoviesFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
    
    
    func movieDetailFetchedSuccessfully(details: MovieDetails) {
        movieDetail.append(details)
        view.loadMovieDetail()
    }
    
    func movieDetailFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
    
    
    func fetchDetails(movieId: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchMovieDetails(movieId: movieId)
        }
    }
    
    func fetchSimilars(movieId: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchSimilarMovies(movieId: movieId)
        }
    }

    func viewDidAppear() {
        
    }
    

}
