//
//  MovieDetailRouter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailRouterInterface: class {

}

final class MovieDetailRouter: NSObject {

    weak var presenter: MovieDetailPresenterInterface?

    static func setupModule() -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.output = presenter
        return vc
    }
}

extension MovieDetailRouter: MovieDetailRouterInterface {

}

