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
    func viewDidLoad()
}

class ListPresenter {

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
    func viewDidLoad() {
    
    }
    
    func viewDidAppear() {
        
    }
    

}
