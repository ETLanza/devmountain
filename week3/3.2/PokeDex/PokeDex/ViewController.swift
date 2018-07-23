//
//  ViewController.swift
//  PokeDex
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    //MARK: - Properties
    
    //MARK: - IBOutlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeWeightLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        PokemonController.searchForPokemon(by: searchText) { (pokemon) in
            guard let pokemon = pokemon else { return }
            DispatchQueue.main.async {
            self.pokeSearchBar.text = ""
            self.pokeIdLabel.text = "\(pokemon.id)"
            self.pokeNameLabel.text = pokemon.name
            self.pokeWeightLabel.text = "\(pokemon.weight)"
            }
            
            PokemonController.getPokemonImage(pokemon, completion: { (image) in
                DispatchQueue.main.async {
                    self.pokeImageView.image = image                    
                }
            })
        }
    }
}

