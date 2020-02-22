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
    private let listMovieHeaderView: ListMovieHeaderView = ListMovieHeaderView()
    private let listMovieHeaderCell: ListMovieHeaderCell = ListMovieHeaderCell()

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = listView
        hideKeyboardWhenTappedAround()
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
