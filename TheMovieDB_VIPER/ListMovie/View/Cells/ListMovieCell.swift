//
//  ListCollectionViewCell.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class ListMovieCell: UITableViewCell {
    private let CellID = "CellID"

    lazy var movieImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var headerLabel:UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.mainTextColor
        label.text = "Marriage Story (2019)"
        label.font = Constants.Fonts.headerFont
        return label
    }()
    
    lazy var shortDescriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.defaultFont
        return label
    }()

    lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.text = "12.12.12"
        label.font = Constants.Fonts.dateFont
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CellID)
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension ListMovieCell : SetupView {
    func buildViewHierarchy() {
        self.addSubviews(movieImage, headerLabel, shortDescriptionLabel, dateLabel)
    }
    
    func setupConstraints() {
        movieImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        
        headerLabel.anchor(top: movieImage.topAnchor, leading: movieImage.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 20))
        
        shortDescriptionLabel.anchor(top: nil, leading: movieImage.trailingAnchor, bottom: movieImage.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 15, right: 50))
        
        dateLabel.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 20))

    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
