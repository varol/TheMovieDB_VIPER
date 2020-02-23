//
//  ListPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol ListPresenterInterface: class {
    func viewDidAppear()
    func searchingMovies(query: String)
    func rowTapped(movieID: String)
}

final class ListPresenter {

    unowned var view: ListViewControllerInterface
    let router: ListRouterInterface?
    let interactor: ListInteractorInterface?

    init(interactor: ListInteractorInterface, router: ListRouterInterface, view: ListViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension ListPresenter: ListPresenterInterface {
    
    func viewDidAppear() {
        DispatchQueue.main.async {
            self.interactor?.fetchUpcomingMovies()
            self.interactor?.fetchNowPlayingMovies()
        }
    }

    func searchingMovies(query: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchSearchMovies(query: query)
        }
    }
    
    func rowTapped(movieID: String) {
        router?.navigateToDetailWith(movieID: movieID)
    }
}

extension ListPresenter: MovieListInteractorOutputProtocol {
    func searchingMoviesFetchedSuccessfully(movies: SearchMovies) {
        view.loadSearchingMovies(searchMovies: movies)
    }
    
    func searchingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
    func nowPlayingMoviesFetchedSuccessfully(movies: NowPlayingMovies) {
        view.loadNowPlayingMovies(nowPlayingMovies: movies)
    }
    
    func nowPlayingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
    func upcomingMoviesFetchedSuccessfully(movies: UpcomingMovies) {
        view.loadUpcomingMovies(upcomingMovies: movies)
    }
    
    func upcomingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
}
