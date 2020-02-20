//
//  ListInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol ListInteractorInterface: class {

}

class ListInteractor {
    weak var presenter: ListPresenterInterface?
}

extension ListInteractor: ListInteractorInterface {

}
