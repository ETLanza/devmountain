//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Eric Lanza on 7/20/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //MARK: - Properties
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    // MARK: - UITableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
            else { return UITableViewCell() }
        
        let movie = MovieController.shared.movies[indexPath.row]
        
        MovieController.getPosterImageFor(movie: movie) { (image) in
            cell.posterImage = image
        }
        cell.movie = movie
        
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            guard let destinationVC = segue.destination as? MovieDetailViewController,
                let cell = sender as? MovieTableViewCell else { return }
            destinationVC.movie = cell.movie
            destinationVC.posterImage = cell.posterImage
        }
    }
}

//MARK: - UISearchBarDelegate Methods
extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        MovieController.searchForMovieBy(searchTerm: searchTerm) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
