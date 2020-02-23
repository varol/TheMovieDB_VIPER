//
//  SearchResultView.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class SearchResultView: UIView {
    fileprivate let cellId = "cellId"
    var searchMovieArray = [SearchResult]()

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}

}

extension SearchResultView : SetupView {
    func buildViewHierarchy() {
        self.addSubviews(tableView)
    }
    
    func setupConstraints() {
        tableView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))

    }

    func setupAdditionalConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension SearchResultView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SearchResultTableViewCell ?? SearchResultTableViewCell(style: .default, reuseIdentifier: cellId)
        cell.accessoryType = .disclosureIndicator
        cell.movieLabel.text = searchMovieArray[indexPath.row].title
        let resource = URL(string: Constants.BaseURL.imageBaseURL + (searchMovieArray[indexPath.row].backdropPath ?? Constants.BaseURL.noImage))
        let placeholder = UIImage(named: "header")
        cell.movieImage.kf.setImage(with: resource, placeholder: placeholder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Sizes.searchTableViewCellHeight
    }

}
