//
//  SimilarMoviesCollectionViewCell.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    lazy var headerImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.descriptionFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textDropShadow()
        return label
    }()

    func configure(similarMovie: SimilarMoviesResult){
        titleLabel.text = similarMovie.title
        guard let resource = URL(string: Constants.BaseURL.imageBaseURL + similarMovie.posterPath) else {return}
        let placeholder = UIImage(named: "header")
        self.headerImage.kf.setImage(with: resource, placeholder: placeholder)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SimilarMoviesCollectionViewCell : SetupView {
    func buildViewHierarchy() {
        self.addSubviews(headerImage, titleLabel)
    }
    
    func setupConstraints() {
        headerImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 30, right: 20))
        
        titleLabel.anchor(top: headerImage.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}

