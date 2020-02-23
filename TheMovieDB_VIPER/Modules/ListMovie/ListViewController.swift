//
//  ListViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

protocol ListViewControllerInterface: class {
    func loadUpcomingMovies(upcomingMovies: UpcomingMovies)
    func loadNowPlayingMovies(nowPlayingMovies: NowPlayingMovies)
    func loadSearchingMovies(searchMovies: SearchMovies)
}

final class ListViewController: UIViewController {
    
    var presenter: ListPresenterInterface?
    private let listView: ListView = ListView()
    private let notificationCenter = NotificationCenter.default
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = listView
        hideKeyboardWhenTappedAround()
        goToDetailsPage()
        startSearch()
        prepareNavBar()
    }
    
    @objc func startSearch(){
        listView.searchMovies = {[weak self] movieKeyword in
            self?.presenter?.searchingMovies(query: movieKeyword)
        }

    }
    
    func goToDetailsPage(){
        listView.rowTapped = {[weak self] movieID in
            guard let self = self else { return }
            self.presenter?.rowTapped(movieID: movieID)
        }
    }
    
    private func prepareNavBar() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = Constants.Colors.backItemColor
        self.navigationItem.backBarButtonItem = backItem
    }
}

extension ListViewController: ListViewControllerInterface {
    func loadSearchingMovies(searchMovies: SearchMovies) {
        self.listView.searchMovieArray = searchMovies.results
        DispatchQueue.main.async {
            self.listView.searchTableView.reloadData()
        }
    }
    
    func loadNowPlayingMovies(nowPlayingMovies: NowPlayingMovies) {
        listView.nowPlayingMovieArray = nowPlayingMovies.results
    }
    
    func loadUpcomingMovies(upcomingMovies: UpcomingMovies) {
        self.listView.movieArray = upcomingMovies.results
        DispatchQueue.main.async {
            self.listView.tableView.reloadData()
        }
    }
    
}
