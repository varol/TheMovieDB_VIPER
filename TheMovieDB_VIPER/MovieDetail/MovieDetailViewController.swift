//
//  MovieDetailViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerInterface: class {

}

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {

}
