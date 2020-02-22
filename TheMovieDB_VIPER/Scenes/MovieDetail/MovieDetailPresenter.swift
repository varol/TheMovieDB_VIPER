//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface: class {

}

class MovieDetailPresenter {

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

}
