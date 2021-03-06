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
    @IBOutlet weak var resultImage: UIImageView!
    
    // data passed in from previous view
    var team = PFObject(className: "Team")
    var pokemonPlaceInTeam: Int = -1
    var pokemonName: String = ""
    var pokemonId: Int = -1
    var abilityArray: [String] = [String]()
    var moveArray: [String] = [String]()
    
    @IBAction func onCancelTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddTouch(_ sender: Any) {
        if searchBar.text == "" || debuggingLabel.text == "Pokemon not found" {
            self.showToast(message: "Search valid Pokemon!", font: .systemFont(ofSize: 12.0))
        } else {
            self.performSegue(withIdentifier: "pokeBuildSegue", sender: nil)
        }
    }
    
    @IBAction func onGetPokemon(_ sender: Any) {
        PokemonAPI().pokemonService.fetchPokemon(searchBar.text?.lowercased() ?? "") { result in
            DispatchQueue.main.async {
            if (self.searchBar.text != "") {
                    switch result {
                    case .success(let pokemon):
                        // set up data
                        self.pokemonName = pokemon.name!
                        self.pokemonId = pokemon.id!
                        self.debuggingLabel.text = pokemon.name!
                        self.resultImage.image = UIImage(named: (String(self.pokemonId) + ".png"))
                        
                        self.abilityArray.removeAll()
                        for i in 0..<pokemon.abilities!.count {
                            self.abilityArray.append((pokemon.abilities?[i].ability?.name)!)
                        }
                        
                        self.moveArray.removeAll()
                        for i in 0..<pokemon.moves!.count {
                            self.moveArray.append((pokemon.moves?[i].move?.name)!)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.debuggingLabel.text = "Pokemon not found"
                        self.resultImage.image = UIImage(named: ("0.png"))
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        self.setupHideKeyboardOnTap()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        PokemonAPI().pokemonService.fetchPokemon(searchBar.text?.lowercased() ?? "") { result in
            DispatchQueue.main.async {
                if (self.searchBar.text != "") {
                    switch result {
                    case .success(let pokemon):
                        // set up data
                        self.pokemonName = pokemon.name!
                        self.pokemonId = pokemon.id!
                        self.debuggingLabel.text = pokemon.name!
                        self.resultImage.image = UIImage(named: (String(self.pokemonId) + ".png"))
                        
                        self.abilityArray.removeAll()
                        for i in 0..<pokemon.abilities!.count {
                            self.abilityArray.append((pokemon.abilities?[i].ability?.name)!)
                        }

                        self.moveArray.removeAll()
                        for i in 0..<pokemon.moves!.count {
                            self.moveArray.append((pokemon.moves?[i].move?.name)!)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.debuggingLabel.text = "Pokemon not found"
                        self.resultImage.image = UIImage(named: ("0.png"))
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PokemonBuilderViewController
        
        destination.team = self.team
        
        destination.pokemonName = self.pokemonName
        destination.pokemonId = self.pokemonId
        destination.abilityArray = self.abilityArray
        destination.moveArray = self.moveArray
        destination.pokemonPlaceInTeam = self.pokemonPlaceInTeam
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
}
