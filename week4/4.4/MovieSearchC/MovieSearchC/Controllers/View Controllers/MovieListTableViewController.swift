//
//  MovieListTableViewController.swift
//  MovieSearchC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ETLMovieController.shared().movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = ETLMovieController.shared().movies[indexPath.row]
        
        if movie.posterPath == nil {
            cell.moviePosterImageView.image = UIImage.init(named: "noImage")
        } else {
            ETLMovieController.shared().fetchMoviePoster(for: movie) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    cell.moviePosterImageView.image = image
                }
            }
        }
        cell.movieTitleLabel.text = movie.title
        cell.movieRatingLabel.text = "\(movie.rating)"
        cell.movieOverviewLabel.text = movie.overview
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        ETLMovieController.shared().fetchMovies(forSearchTerm: searchTerm) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
