//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Eric Lanza on 7/20/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    var posterImage: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRaitingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let movie = movie else { return }
        if let posterImage = posterImage {
            DispatchQueue.main.async {
                self.movieImageView.image = posterImage
            }
        }
        DispatchQueue.main.async {
            self.movieTitleLabel.text = movie.title
            self.movieRaitingLabel.text = "\(movie.rating)"
            self.movieSummaryLabel.text = movie.summary
        }
    }
}
