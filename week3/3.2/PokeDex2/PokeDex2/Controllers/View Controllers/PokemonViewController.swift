//
//  PokemonViewController.swift
//  PokeDex2
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeWeightLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
}

//MARK: - SearchBarDelegate Methods
extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text?.lowercased(), !searchText.isEmpty else { return }
        PokemonController.getPokemon(nameOrID: searchText) { (pokemon) in
            guard let pokemon = pokemon else { return }
            DispatchQueue.main.async {
                self.pokeSearchBar.text = ""
                self.pokeNameLabel.text = pokemon.name
                self.pokeWeightLabel.text = "\(pokemon.weight)"
                self.pokeIDLabel.text = "\(pokemon.id)"
            }
            PokemonController.getImage(for: pokemon, completion: { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.pokeImageView.image = image
                }
            })
        }
    }
}

