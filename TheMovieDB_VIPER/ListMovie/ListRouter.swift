//
//  ListRouter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation
import UIKit

protocol ListRouterInterface: class {

}

class ListRouter: NSObject {

    weak var presenter: ListPresenterInterface?

    static func setupModule() -> ListViewController {
        let vc = ListViewController()
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}

extension ListRouter: ListRouterInterface {

}

