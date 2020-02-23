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
    func prepareMovieDetail(movieDetail: MovieDetails)
    func loadSimilarMovies(similarMovies: SimilarMovies)
}

final class MovieDetailViewController: UIViewController {
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
        presenter?.fetchDetails(movieId: movieID)
        presenter?.fetchSimilars(movieId: movieID)
    }
    
    override func viewDidLoad() {
        self.view = detailView
        newRequest()
    }
    
    private func newRequest(){
        detailView.rowTapped = {[weak self] newID in
            guard let self = self else { return }
            self.presenter?.fetchDetails(movieId: newID)
            self.presenter?.fetchSimilars(movieId: newID)
        }
    }
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
    func loadSimilarMovies(similarMovies: SimilarMovies) {
        detailView.similarMoviesArray = similarMovies.results
        detailView.collectionView.reloadData()
    }
    
    func prepareMovieDetail(movieDetail: MovieDetails) {
        self.title = movieDetail.title
        detailView.headerLabel.text = movieDetail.title
        detailView.descriptionText.text = movieDetail.overview
        detailView.dateLabel.text = movieDetail.releaseDate
        detailView.ratingLabel.text = String(movieDetail.voteAverage)
        guard let resource = URL(string: Constants.BaseURL.imageBaseURL + (movieDetail.backdropPath ?? movieDetail.posterPath)) else {return}
        let placeholder = UIImage(named: "header")
        detailView.movieImage.kf.setImage(with: resource, placeholder: placeholder)
        detailView.imdbID = movieDetail.imdbID
    }

}
