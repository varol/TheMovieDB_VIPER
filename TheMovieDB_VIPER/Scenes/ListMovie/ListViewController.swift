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
    func loadSearchingMovies()
}

class ListViewController: UIViewController {
    var presenter: ListPresenterInterface?
    private let listView: ListView = ListView()
    private let searchView: SearchResultView = SearchResultView()
    let nc = NotificationCenter.default

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: NSNotification.Name(rawValue: "startSearch"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = listView
        hideKeyboardWhenTappedAround()
        goToDetailsPage()
        startSearch()
        nc.addObserver(self, selector: #selector(startSearch), name: Notification.Name("startSearch"), object: nil)
    }
    
    @objc func startSearch(){
        print("start çalıştı")
        listView.searchMovies = {[weak self] movieKeyword in
            self?.presenter?.searchingMovies(query: movieKeyword)
        }

    }
    
    func goToDetailsPage(){
        listView.rowTapped = {[weak self] movieID in
            guard self != nil else {return}
            let vc = MovieDetailRouter.setupModule()
            vc.movieID = movieID
            let backItem = UIBarButtonItem()
            backItem.title = ""
            backItem.tintColor = Constants.Colors.backItemColor
            self?.navigationItem.backBarButtonItem = backItem
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ListViewController: ListViewControllerInterface {
    func loadSearchingMovies() {
        if let searchMovieData = self.presenter?.getSearchingData(){
            print("search yes!")
            self.listView.searchMovieArray = searchMovieData.first!.results
            DispatchQueue.main.async {
                self.listView.searchTableView.reloadData()
            }
        }
    }
    
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
