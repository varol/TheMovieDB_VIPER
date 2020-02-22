//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInterface: class {

}

class MovieDetailInteractor {
    weak var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {

}
