//
//  ListRouter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation
import UIKit

protocol ListRouterInterface {
    func navigateToDetailWith(movieID: String)
}

final class ListRouter: NSObject {

    weak var presenter: ListPresenterInterface?
    private weak var viewController: ListViewController?
    
    static func setupModule() -> ListViewController {
        let vc = ListViewController()
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}

extension ListRouter: ListRouterInterface {
    func navigateToDetailWith(movieID: String) {
        let vc = MovieDetailRouter.setupModule()
        vc.movieID = movieID
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

