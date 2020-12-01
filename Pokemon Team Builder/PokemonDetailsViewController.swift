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

class PokemonDetailsViewController: UIViewController, UISearchBarDelegate{
    /*
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    */
    
    
    
    @IBOutlet weak var debuggingLabel: UILabel! // displays the first result of pokemon search
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var abilityPicker: UIPickerView!
    
    @IBAction func OnAddPokemon(_ sender: Any) {        // todo: with the data on the page, make a dictionary of attributes named "Pokemon" and under the keys " name," "nature," "moves," "ability," and "item," and send it to teambuilderviewcontroller
        
        // var pokemon = [String: [String]]()
        /*
         pseudocode:
         
         Pokemon["Name"] = searchbar.text.lowercased()
         Pokemon["Nature"] = nature picker value
         Pokemon["Moves"] = [array of moves from the four fields]
         Pokemon["Item"] = item picker value
         
         */
    }
    

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

   
    // to pass into the next screen
    
    var pokemonName: String = ""
    var pokemonId: Int = -1
    var abilityArray: [String] = [String]()
    var moveArray: [String] = [String]()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        PokemonAPI().pokemonService.fetchPokemon(searchText.lowercased()) { result in
            
            switch result {
            case .success(let pokemon):
                // set up data
                // any and all print statements below are for debug purposes
                
                // get pokemon name
                print(pokemon.name)
                self.pokemonName = pokemon.name!
                
                // get pokemon id
                print(pokemon.id)
                self.pokemonId = pokemon.id!
                
                print(pokemon.abilities?[0].ability?.name)
                
                // data for ability picker
                
                print(pokemon.abilities?.count)

                for i in 0..<pokemon.abilities!.count {
                    self.abilityArray.append((pokemon.abilities?[i].ability?.name)!)
                }
                
                print(self.abilityArray)

                // data for move picker
                
                
                print(pokemon.moves?.count)
                
                for i in 0..<pokemon.moves!.count {
                    self.moveArray.append((pokemon.moves?[i].move?.name)!)
                }
                
                print(self.moveArray)
                
                
                
                DispatchQueue.main.async {
                    self.debuggingLabel.text = pokemon.name
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.debuggingLabel.text = "Pokemon not found"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PokemonBuilderViewController
        
        destination.pokemonName = self.pokemonName
        destination.pokemonId = self.pokemonId
        destination.abilityArray = self.abilityArray
        destination.moveArray = self.moveArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        
    }
    
    /*
     todo: query the pokemon and fetch the natures, moves
     and any other attributes that the pokemon has
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
