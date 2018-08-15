//
//  PokemonViewController.swift
//  PokedexHybrid
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Properties
    
    var pokemon: ETLPokemon? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        ETLPokemonController.shared().fetchPokemone(withSearchTerm: searchText) { (pokemon) in
            self.pokemon = pokemon
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.idLabel.text = "\(pokemon.identifier)"
            self.abilitiesLabel.text = "\(pokemon.abilities.joined(separator: ", "))"
        }
    }
    
}
