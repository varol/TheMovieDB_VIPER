//
//  MovieDetailView.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 22.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    let cellId = "cellId"
    var similarMoviesArray = [SimilarMoviesResult]()
    var imdbID = ""
    var rowTapped : ((String) -> Void)? = nil

    let stackView: UIScrollView = {
        let stack = UIScrollView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var movieImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "header")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var headerLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.text = "The Lord Of The Rings The Lord Of The Rings"
        label.textColor = Constants.Colors.mainTextColor
        label.font = Constants.Fonts.headerFont
        return label
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.defaultFont
        return label
    }()

    lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.text = "12.02.2020"
        label.font = Constants.Fonts.dateFont
        return label
    }()

    lazy var ratingLabel:UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.dateFont
        return label
    }()
    
    lazy var ratingImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "rating")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()

    lazy var imdbButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"imdb"), for: .normal)
        button.addTarget(self, action: #selector(goToIMDB), for: .touchUpInside)
        return button
    }()
    
    @objc func goToIMDB(){
        if let url = URL(string: "https://www.imdb.com/title/" + imdbID) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}

}

extension MovieDetailView: SetupView {
    func buildViewHierarchy() {
        self.addSubview(stackView)

        self.addSubviews(movieImage, headerLabel, descriptionLabel, dateLabel, imdbButton, ratingLabel, collectionView, ratingImage)
    }
    
    func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        
        stackView.anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor)
        
        movieImage.anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 250))
        
        headerLabel.anchor(top: movieImage.bottomAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        descriptionLabel.anchor(top: headerLabel.bottomAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        imdbButton.anchor(top: descriptionLabel.bottomAnchor, leading: nil, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20),size: .init(width: 50, height: 25))
        
        dateLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: imdbButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        dateLabel.centerYAnchor.constraint(equalTo: imdbButton.centerYAnchor).isActive = true
        
        ratingLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: dateLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        ratingLabel.centerYAnchor.constraint(equalTo: imdbButton.centerYAnchor).isActive = true
        
        ratingImage.anchor(top: nil, leading: nil, bottom: nil, trailing: ratingLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 5), size: .init(width: 15, height: 15))
        ratingImage.centerYAnchor.constraint(equalTo: imdbButton.centerYAnchor).isActive = true

        
        collectionView.anchor(top: imdbButton.bottomAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 20, right: 0),size: .init(width: 0, height: 150))
    }
    
    func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimilarMoviesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    }
    
    
}

extension MovieDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SimilarMoviesCollectionViewCell
        cell.configure(similarMovie: similarMoviesArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rowTapped = self.rowTapped {
            rowTapped(String(similarMoviesArray[indexPath.row].id))
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
