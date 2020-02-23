//
//  MovieDetailViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieDetailViewControllerInterface: class {
    func loadMovieDetail()
    func loadSimilarMovies()
}

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterInterface?
    private let detailView: MovieDetailView = MovieDetailView()
    var movieID = String()
    var dataFetched : ((MovieDetails) -> Void)? = nil

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        newRequest()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
        presenter?.fetchDetails(movieId: movieID)
        presenter?.fetchSimilars(movieId: movieID)
    }
    
    override func viewDidLoad() {
        self.view = detailView
        newRequest()
    }
    
    func newRequest(){
        detailView.rowTapped = {[weak self] newID in
            print(newID)
            self?.presenter?.fetchDetails(movieId: newID)
            self?.presenter?.fetchSimilars(movieId: newID)
            DispatchQueue.main.async {
                self?.loadSimilarMovies()
                self?.loadMovieDetail()
                self?.detailView.layoutIfNeeded()
            }
        }
    }

}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
    func loadSimilarMovies() {
        if let similarMovies = self.presenter?.getSimilarMovies(){
            detailView.similarMoviesArray = similarMovies.results
            detailView.collectionView.reloadData()
        }
    }
    
    func loadMovieDetail() {

        if let movieDetail = self.presenter?.getMovieDetails(){
            self.title = movieDetail.title
            detailView.headerLabel.text = movieDetail.title
            detailView.descriptionLabel.text = movieDetail.overview
            detailView.dateLabel.text = movieDetail.releaseDate
            detailView.ratingLabel.text = String(movieDetail.voteAverage)
            guard let resource = URL(string: Constants.BaseURL.imageBaseURL + (movieDetail.backdropPath ?? Constants.BaseURL.noImage)) else {return}
            let placeholder = UIImage(named: "header")
            detailView.movieImage.kf.setImage(with: resource, placeholder: placeholder)
            detailView.imdbID = movieDetail.imdbID
        }

    }
}
