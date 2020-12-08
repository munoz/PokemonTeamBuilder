//
//  TeamViewController.swift
//  Pokemon Team Builder
//
//  Created by user180060 on 12/7/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teamTitle: UINavigationItem!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var pokemons =  [PFObject]()
    var team = PFObject(className: "Team")
    
    @IBAction func onReturnTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "returnTeamsSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        
        self.teamTitle.title = (team["teamName"] as! String)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Pokemon")
        query.includeKey("teamID")
        query.whereKey("teamID" , equalTo: team)
    
        query.findObjectsInBackground { (pkm, error) in
            if pkm != nil {
                self.pokemons = pkm!
                self.pokemonTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "SingleTeamTableViewCell") as! SingleTeamTableViewCell
        
        let pokemon = pokemons[indexPath.row]
        cell.pokemonNameLabel.text = pokemon["pokeName"] as? String
        
        let moveset = pokemon["moveset"] as! [String]
        cell.moveOneLabel.text = emptyLabel(label: moveset[0])
        cell.moveTwoLabel.text = emptyLabel(label: moveset[1])
        cell.moveThreeLabel.text = emptyLabel(label: moveset[2])
        cell.moveFourLabel.text = emptyLabel(label: moveset[3])
        
        cell.abilityLabel.text = emptyLabel(label: (pokemon["ability"] as? String)!)
        cell.natureLabel.text = emptyLabel(label: (pokemon["nature"] as? String)!)
        cell.genderLabel.text = emptyLabel(label: (pokemon["gender"] as? String)!)
        cell.itemLabel.text = emptyLabel(label: (pokemon["item"] as? String)!)
        cell.pokeImage.image = UIImage(named: (pokemon["pokeID"] as! String + ".png"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func emptyLabel(label: String) -> String {
        if label == "" {
            return "-----"
        } else {
            return label
        }
    }
}
