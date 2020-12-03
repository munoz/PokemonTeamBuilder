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
    
    
    @IBOutlet weak var debuggingLabel: UILabel! // displays the first result of pokemon search
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var abilityPicker: UIPickerView!
    
    @IBAction func onAddTouch(_ sender: Any) {
        if searchBar.text == "" || debuggingLabel.text == "Pokemon not found" {
            self.showToast(message: "Search valid Pokemon!", font: .systemFont(ofSize: 12.0))
        } else {
            self.performSegue(withIdentifier: "pokeBuildSegue", sender: nil)
        }
    }
    
    
    @IBAction func onGetPokemon(_ sender: Any) {
        PokemonAPI().pokemonService.fetchPokemon(searchBar.text?.lowercased() ?? "") { result in
            
            if (self.searchBar.text != "") {
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
    }
    
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
    
    // Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        PokemonAPI().pokemonService.fetchPokemon(searchBar.text?.lowercased() ?? "") { result in
            
            if (self.searchBar.text != "") {
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
    }
    
    // todo: take care of the repeated api calls
   
    // to pass into the next screen
    
    var team = PFObject(className: "Team")
    
    var pokemonName: String = ""
    var pokemonId: Int = -1
    var abilityArray: [String] = [String]()
    var moveArray: [String] = [String]()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 
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
        
        
        self.setupHideKeyboardOnTap()
        
    }
    
    // Source: https://stackoverflow.com/questions/31540375/how-to-toast-message-in-swift
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
