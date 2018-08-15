//
//  PokemonViewController.swift
//  PokedexC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: - Properties
    var pokemon: ETLPokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    func updateViews() {
        if let pokemon = pokemon {
            DispatchQueue.main.async {
                self.nameLabel.text = pokemon.name
                self.idLabel.text = "\(pokemon.number)"
                self.abilitiesLabel.text = "\(pokemon.abilities.joined(separator: ", "))"
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.text = ""
        
        ETLPokemonController.fetchPokemon(withSearchTerm: searchText) { (pokemon) in
            self.pokemon = pokemon
        }
    }
}
