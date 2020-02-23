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
    func getUpcomingMovies() -> [UpcomingMovies]?
    func getNowPlayingMovies() -> [NowPlayingMovies]?
    func getSearchingData() -> [SearchMovies]?
    func searchingMovies(query: String)
}

protocol MovieListInteractorOutputProtocol: class {
    func upcomingMoviesFetchedSuccessfully(movies: UpcomingMovies)
    func upcomingMoviesFetchingFailed(withError error: Error)
    func nowPlayingMoviesFetchedSuccessfully(movies: NowPlayingMovies)
    func nowPlayingMoviesFetchingFailed(withError error: Error)
    func searchingMoviesFetchedSuccessfully(movies: SearchMovies)
    func searchingMoviesFetchingFailed(withError error: Error)
}

class ListPresenter {

    unowned var view: ListViewControllerInterface
    let router: ListRouterInterface?
    let interactor: ListInteractorInterface?
    
    var upcomingMovies = [UpcomingMovies]()
    var nowPlayingMovies = [NowPlayingMovies]()
    var searchingMovieData = [SearchMovies]()

    init(interactor: ListInteractorInterface, router: ListRouterInterface, view: ListViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension ListPresenter: ListPresenterInterface, MovieListInteractorOutputProtocol {
    
    func searchingMoviesFetchedSuccessfully(movies: SearchMovies) {
        self.searchingMovieData.append(movies)
        view.loadSearchingMovies()
    }
    
    func searchingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)

    }
    
    func getSearchingData() -> [SearchMovies]? {
        return searchingMovieData
    }
    
    
    func searchingMovies(query: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchSearchMovies(query: query)
        }
    }
    
    func getNowPlayingMovies() -> [NowPlayingMovies]? {
        return nowPlayingMovies
    }
    
    func getUpcomingMovies() -> [UpcomingMovies]? {
        return upcomingMovies
    }

    func nowPlayingMoviesFetchedSuccessfully(movies: NowPlayingMovies) {
        self.nowPlayingMovies.append(movies)
        view.loadNowPlayingMovies()
    }
    
    func nowPlayingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func upcomingMoviesFetchedSuccessfully(movies: UpcomingMovies) {
        self.upcomingMovies.append(movies)
        view.loadUpcomingMovies()
    }
    
    func upcomingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
    func viewDidAppear() {
        DispatchQueue.main.async {
            self.interactor?.fetchUpcomingMovies()
            self.interactor?.fetchNowPlayingMovies()
        }
    }
}

