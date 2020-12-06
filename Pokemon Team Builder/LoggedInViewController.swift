//
//  LoggedInViewController.swift
//  Pokemon Team Builder
//
//  Created by studentProfile on 11/5/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class LoggedInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teamTableView: UITableView!
    
    var teams = [PFObject]()
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        sceneDelegate.window?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = PFUser.current()!
        teamTableView.dataSource = self
        teamTableView.delegate = self
        /*
         todo: query the current user's teams and display them on this screen
         */
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Team")
        query.includeKey("userID")
    
        query.findObjectsInBackground { (teams, error) in
            if teams != nil {
                self.teams = teams!
                self.teamTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
        
        let team = teams[indexPath.row]
        
        cell.teamNameLabel.text = team["teamName"] as? String
        
//        let url = URL(fileURLWithPath: "/PokemonTeamBuilder/bower_components/pokemon-sprites/sprites/pokemon/model/1.png")
        
//        let imageData:NSData = NSData(contentsOf: url)!
        
//        let image = UIImage(data: imageData as Data)
        
        let spriteArray = team["pokeSprites"] as! [String]
        
        cell.pokeOneImage.image = UIImage(named: (spriteArray[0] + ".png"))
        cell.pokeTwoImage.image = UIImage(named: (spriteArray[1] + ".png"))
        cell.pokeThreeImage.image = UIImage(named: (spriteArray[2] + ".png"))
        cell.pokeFourImage.image = UIImage(named: (spriteArray[3] + ".png"))
        cell.pokeFiveImage.image = UIImage(named: (spriteArray[4] + ".png"))
        cell.pokeSixImage.image = UIImage(named: (spriteArray[5] + ".png"))
        
        
        
        return cell
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
