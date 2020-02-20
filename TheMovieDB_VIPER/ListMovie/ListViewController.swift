//
//  ListViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

protocol ListViewControllerInterface: class {

}

class ListViewController: UIViewController {
    var presenter: ListPresenterInterface?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = ListView()
        hideKeyboardWhenTappedAround()
    }
}

extension ListViewController: ListViewControllerInterface {

}
