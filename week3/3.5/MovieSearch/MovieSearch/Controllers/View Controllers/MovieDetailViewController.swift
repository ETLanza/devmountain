//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Eric Lanza on 7/20/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    var posterImage: UIImage? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBAction func favortieButtonPressed(_ sender: UIButton) {
        guard let movie = movie else { favoriteButton.isHidden = true; return }
        movie.isFavorite = !movie.isFavorite
        updateViews()
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let movie = movie,
            let posterImage = posterImage else { return }
        movieImageView.image = posterImage
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.rating)"
        movieReleaseDateLabel.text = movie.releaseDate
        movieSummaryLabel.text = movie.summary
        let imageName = movie.isFavorite ? "favoritedStar"  : "star"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
