//
//  TeamBuilderViewController.swift
//  Pokemon Team Builder
//
//  Created by user180091 on 11/16/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import PokemonAPI

/*
 todo: start using pokeapi, possibly install the pokeapi pod
 
 schema:
 objectId    String    unique id for the team (default field)
 user    Pointer    Connect the team to its respective user
 team    Array    Consists of the pokemon team
 name    String    Name of the Team
 
 
 team: array of dictionaries, representing pokemon and their attributes
 abilities, all that
 
*/


class TeamBuilderViewController: UIViewController {

    @IBAction func onSaveTeam(_ sender: Any) {

        self.performSegue(withIdentifier: "saveSegue", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier != "saveSegue") {
        let destination = segue.destination as! PokemonDetailsViewController
        
        destination.team = self.team
        destination.pokemonPlaceInTeam = self.pokemonPlaceInTeam
        }
    }
    
    
    @IBOutlet weak var firstPokemonButton: UIButton!
    @IBOutlet weak var secondPokemonButton: UIButton!
    @IBOutlet weak var thirdPokemonButton: UIButton!
    @IBOutlet weak var fourthPokemonButton: UIButton!
    @IBOutlet weak var fifthPokemonButton: UIButton!
    @IBOutlet weak var sixthPokemonButton: UIButton!
    
    func segue(button: UIButton, place: Int) {
        if (button.currentImage == UIImage(named: "0.png")) {
            self.pokemonPlaceInTeam = place
            self.performSegue(withIdentifier: "pokemonSearchSegue", sender: nil)
        } else {
            print("error: pokemon")
        }
    }
    
    @IBAction func onEditFirstPokemon(_ sender: Any) {
        segue(button: firstPokemonButton, place: 0)
    }
    
    @IBAction func onEditSecondPokemon(_ sender: Any) {
        segue(button: secondPokemonButton, place: 1)
    }
    
    @IBAction func onEditThirdPokemon(_ sender: Any) {
        segue(button: thirdPokemonButton, place: 2)
    }
    
    @IBAction func onEditFourthPokemon(_ sender: Any) {
        segue(button: fourthPokemonButton, place: 3)
    }
    
    @IBAction func onEditFifthPokemon(_ sender: Any) {
        segue(button: fifthPokemonButton, place: 4)
    }
    
    @IBAction func onEditSixthPokemon(_ sender: Any) {
        segue(button: sixthPokemonButton, place: 5)
    }
        
    
    
    
    
    let currentUser = PFUser.current()!
    
    // data passed from previous view
    var team = PFObject(className: "Team")
    
    var pokemonPlaceInTeam: Int = -1
    
    
    
    
    /*
     todo:
     
     if a button has a pokemon value attached to it, the pokemon values are edited instead of a new one being made
     
     otherwise, a new pokemon is made
     
     
     each one of those buttons has a place, from 0 to 5.
     
     
     
     */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spriteArray = team["pokeSprites"] as! [String]
        
        print(spriteArray[0])
        
        firstPokemonButton.setImage(UIImage(named: spriteArray[0] + ".png"), for: .normal)
        secondPokemonButton.setImage(UIImage(named: spriteArray[1] + ".png"), for: .normal)
        thirdPokemonButton.setImage(UIImage(named: spriteArray[2] + ".png"), for: .normal)
        fourthPokemonButton.setImage(UIImage(named: spriteArray[3] + ".png"), for: .normal)
        fifthPokemonButton.setImage(UIImage(named: spriteArray[4] + ".png"), for: .normal)
        sixthPokemonButton.setImage(UIImage(named: spriteArray[5] + ".png"), for: .normal)
 
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
