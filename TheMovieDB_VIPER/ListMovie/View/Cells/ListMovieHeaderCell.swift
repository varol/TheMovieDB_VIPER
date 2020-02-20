//
//  ListMovieHeaderCell.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class ListMovieHeaderCell: UICollectionViewCell {
    
    lazy var headerImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var headerLabel : UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.headerTextColor
        label.font = Constants.Fonts.headerFont
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListMovieHeaderCell : SetupView {
    func buildViewHierarchy() {
        self.addSubviews(headerImage)
        headerImage.addSubviews(headerLabel)
    }
    
    func setupConstraints() {
        headerImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
