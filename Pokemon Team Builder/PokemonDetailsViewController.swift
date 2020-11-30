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
        
        var pokemon = [String: [String]]()
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

   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        PokemonAPI().pokemonService.fetchPokemon(searchText.lowercased()) { result in
            
            switch result {
            case .success(let pokemon):
                // set up data
                // any and all print statements below are for debug purposes
                // get pokemon name
                print(pokemon.name)
                
                // todo: get a pic of the pokemon!
                
                print(pokemon.abilities?[0].ability?.name)
                
                // data for ability picker
                var abilityArray: [String] = [String]()
                
                print(pokemon.abilities?.count)

                for i in 0..<pokemon.abilities!.count {
                    abilityArray.append((pokemon.abilities?[i].ability?.name)!)
                }
                
                print(abilityArray)

            
                // data for move picker
                var moveArray: [String] = [String]()
                
                print(pokemon.moves?.count)
                
                for i in 0..<pokemon.moves!.count {
                    moveArray.append((pokemon.moves?[i].move?.name)!)
                }
                
                print(moveArray)
                
                
                
                DispatchQueue.main.async {
                    self.debuggingLabel.text = pokemon.name
                    
                    // todo: display abilities in picker
                    
                    
                    // todo: display moves in picker
                    
                    
                    // todo: add an "add move" button n "remove move" button
                    
                    
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.debuggingLabel.text = "Pokemon not found"
                }
            }
        }
        
        
        

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //abilityPicker.delegate = self
        //abilityPicker.dataSource = self

        // Do any additional setup after loading the view.
        
        // todo: when i figure out how to extract
        // the natures and items
        // via this api,
        // the natures and held items for
        // this details page will be implemented.
        
        // load natures
        
        var natureArray: [String] = [String]()
        
        
        PokemonAPI().pokemonService.fetchNatureList(paginationState: .initial(pageLimit: 25)) { result in
            switch result {
            case .success(let pagedNatures):
                print("\(pagedNatures.count!)") // 25
                print(pagedNatures.results?[0])

            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        
        
        // load items
        var itemArray: [String] = [String]()
        
        PokemonAPI().itemService.fetchItemList(paginationState: .initial(pageLimit: 25)) { result in
            switch result {
            case .success(let pagedItems):
                print("\(pagedItems.count!)") // 25
                print(pagedItems.results?[0])

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        /*
         PokemonAPI().pokemonService.fetchNatureList(paginationState: .continuing(pagedNatures, .next)) { result in
             switch result {
             case .success(let pagedNaturesNext):
                 print("Page: \(pagedNaturesNext.currentPage)") // Page: 1
                 print(pagedNaturesNext.results?.first?.url)
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
         */

        
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
