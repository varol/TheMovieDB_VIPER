//
//  SearchResultTableViewCell.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    private let cellId = "cellId"

    lazy var movieImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "header")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var movieLabel:UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.mainTextColor
        label.font = Constants.Fonts.searchResultFont
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchResultTableViewCell : SetupView {
    func buildViewHierarchy() {
        self.addSubviews(movieImage, movieLabel)
    }
    
    func setupConstraints() {
        self.movieImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        self.movieLabel.anchor(top: self.topAnchor, leading: movieImage.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
