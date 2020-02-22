//
//  ListViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

protocol ListViewControllerInterface: class {
    func loadUpcomingMovies()
    func loadNowPlayingMovies()
}

class ListViewController: UIViewController {
    var presenter: ListPresenterInterface?
    private let listView: ListView = ListView()

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = listView
        hideKeyboardWhenTappedAround()
        goToDetailsPage()
    }
    
    func goToDetailsPage(){
        listView.rowTapped = {[weak self] movieID in
            guard self != nil else {return}
            let vc = MovieDetailRouter.setupModule()
            vc.movieID = movieID
            let backItem = UIBarButtonItem()
            backItem.title = ""
            backItem.tintColor = .black
            self?.navigationItem.backBarButtonItem = backItem
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ListViewController: ListViewControllerInterface {
    func loadNowPlayingMovies() {
        if let movieItems = self.presenter?.getNowPlayingMovies(){
            self.listView.nowPlayingMovieArray = movieItems.first!.results
        }
    }
    
    func loadUpcomingMovies() {
        if let movieItems = self.presenter?.getUpcomingMovies(){
            self.listView.movieArray = movieItems.first!.results
        }
        
        DispatchQueue.main.async {
            self.listView.tableView.reloadData()
        }
    }
    
}
