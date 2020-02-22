//
//  SearchInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol SearchInteractorInterface: class {

}

class SearchInteractor {
    weak var presenter: SearchPresenterInterface?
}

extension SearchInteractor: SearchInteractorInterface {

}
