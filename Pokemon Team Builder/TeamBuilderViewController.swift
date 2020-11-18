//
//  TeamBuilderViewController.swift
//  Pokemon Team Builder
//
//  Created by user180091 on 11/16/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse


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

    @IBOutlet weak var teamNameField: UITextField!
    
    @IBAction func onSaveTeam(_ sender: Any) {
        let team = PFObject(className: "Team")
        team["User"] = currentUser
        team["Pokemon"] = ["sdfsdklflskjdskljfskjfsklfjl", "this is a placeholer pay this no mind"]
        
        /*
         add the team to the team database
         */
        
        
        
    }
    
    let currentUser = PFUser.current()!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
