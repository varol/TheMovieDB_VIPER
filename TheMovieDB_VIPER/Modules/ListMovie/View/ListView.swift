//
//  ListView.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    var movieArray = [UpcomingResult]()
    var nowPlayingMovieArray = [NowPlayingResult]()
    var searchMovieArray = [SearchResult]()
    var rowTapped : ((String) -> Void)? = nil
    var searchMovies : ((String) -> Void)? = nil
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"

    //MARK: - UI Elements
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        return searchBar
    }()

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
        return tableView
    }()

    
    lazy var searchView : UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
}

extension ListView : SetupView, UISearchBarDelegate, UISearchDisplayDelegate {
    func buildViewHierarchy() {
        self.addSubviews(searchBar, tableView, searchView)
        self.searchView.addSubview(searchTableView)
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        searchBar.anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        tableView.anchor(top: searchBar.bottomAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        searchView.anchor(top: searchBar.bottomAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300))
        
        searchTableView.anchor(top: searchView.topAnchor, leading: searchView.leadingAnchor, bottom: searchView.bottomAnchor, trailing: searchView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func setupAdditionalConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListMovieCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ListMovieHeaderView.self, forCellReuseIdentifier: headerId)
        searchBar.delegate = self

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let movieString = (searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        if (searchBar.text?.components(separatedBy: " ").count)! > 2 {
            self.searchView.isHidden = false
            if let searchMovies = self.searchMovies {
                searchMovies(String(movieString))
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        } else {
            self.searchView.isHidden = true
        }
    }
}

extension ListView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView ? movieArray.count : searchMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ListMovieCell ?? ListMovieCell(style: .default, reuseIdentifier: cellId)
            cell.accessoryType = .disclosureIndicator
            cell.configure(movieItem: movieArray[indexPath.row])
            return cell
        } else {
            let cell = self.searchTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SearchResultTableViewCell ?? SearchResultTableViewCell(style: .default, reuseIdentifier: cellId)
            cell.accessoryType = .disclosureIndicator
            cell.movieLabel.text = searchMovieArray[indexPath.row].title
            let resource = URL(string: Constants.BaseURL.imageBaseURL + (searchMovieArray[indexPath.row].backdropPath ?? Constants.BaseURL.noImage))
            let placeholder = UIImage(named: "header")
            cell.movieImage.kf.setImage(with: resource, placeholder: placeholder)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == self.tableView ? Constants.Sizes.tableViewCellHeight : Constants.Sizes.searchTableViewCellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == self.tableView ? 250 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: headerId) as? ListMovieHeaderView
        header?.nowPlayingMovieArray = self.nowPlayingMovieArray
        header?.collectionView.reloadData()
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            if let rowTapped = self.rowTapped {
                rowTapped(String(movieArray[indexPath.row].id))
            }
        } else {
            if let rowTapped = self.rowTapped {
                rowTapped(String(searchMovieArray[indexPath.row].id))
            }

        }
    }
}
