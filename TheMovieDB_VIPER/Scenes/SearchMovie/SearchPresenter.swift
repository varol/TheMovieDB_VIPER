//
//  SearchPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol SearchPresenterInterface: class {

}

class SearchPresenter {

    unowned var view: SearchViewControllerInterface
    let router: SearchRouterInterface?
    let interactor: SearchInteractorInterface?

    init(interactor: SearchInteractorInterface, router: SearchRouterInterface, view: SearchViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterInterface {

}
