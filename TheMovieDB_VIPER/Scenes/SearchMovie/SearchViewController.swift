//
//  SearchViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

protocol SearchViewControllerInterface: class {

}

class SearchViewController: UIViewController {
    var presenter: SearchPresenterInterface?
}

extension SearchViewController: SearchViewControllerInterface {

}
