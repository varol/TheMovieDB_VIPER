//
//  ListView.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class ListView: UIView {
    var movieArray = ["Marriage Story","Matrix","Lord Of The Rings","Marriage Story","Matrix","Lord Of The Rings","Marriage Story","Matrix","Lord Of The Rings"]
    fileprivate let cellID = "cellID"
    fileprivate let headerID = "headerID"

    //MARK: - UI Elements
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        return searchBar
    }()

    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()

    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
}

extension ListView : SetupView, UISearchBarDelegate {
    func buildViewHierarchy() {
        self.addSubviews(searchBar, tableView)
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        searchBar.anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        tableView.anchor(top: searchBar.bottomAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func setupAdditionalConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListMovieCell.self, forCellReuseIdentifier: cellID)
    }
    
    
}

extension ListView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ListMovieCell ?? ListMovieCell(style: .default, reuseIdentifier: cellID)
        cell.accessoryType = .disclosureIndicator
        cell.headerLabel.text = movieArray[indexPath.row]
        cell.movieImage.image = UIImage(named: "marriageStory")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Sizes.tableViewCellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? ListMovieHeaderView ?? ListMovieHeaderView(reuseIdentifier: headerID)
        
        return header
    }

}
