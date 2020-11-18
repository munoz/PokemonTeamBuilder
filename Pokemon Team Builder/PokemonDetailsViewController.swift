//
//  PokemonDetailsViewController.swift
//  Pokemon Team Builder
//
//  Created by user180091 on 11/18/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import PokemonAPI

class PokemonDetailsViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var debuggingLabel: UILabel! // displays the first result of pokemon search
    
    
    @IBOutlet weak var PokemonSearch: UISearchBar!
    
    var searchActive : Bool = false
    
    var filtered:[String] = []
    
    
    /*
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
 
 */

    
    func searchPokemon(pokemon: String,  success: @escaping() -> (), failure: @escaping(Error) -> ()) {
        // Example of calling a web service using a name
        PokemonAPI().pokemonService.fetchPokemon(pokemon) { result in
            switch result {
            case .success(let pokemon):
                self.debuggingLabel.text = pokemon.name // some arbitrary pokemon
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonSearch.delegate = self


        // Do any additional setup after loading the view.
    }
    
    /*
     todo: query the pokemon and fetch the natures, moves,
     and any other attributes that the pokemon has.
     
     
     https://pokeapi.co/api/v2/{endpoint}/
     */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
