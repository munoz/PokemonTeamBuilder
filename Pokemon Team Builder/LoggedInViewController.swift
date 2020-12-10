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
    let myRefreshControl = UIRefreshControl()
    
    @IBAction func onViewTouch(_ sender: UIButton) {
        self.performSegue(withIdentifier: "teamViewSegue", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeams()
        
        teamTableView.dataSource = self
        teamTableView.delegate = self
        
        myRefreshControl.addTarget(self, action: #selector(loadTeams), for: .valueChanged)
        teamTableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadTeams()
    }
    
    @objc func loadTeams() {
        let query = PFQuery(className: "Team")
        query.includeKey("userID")
        query.whereKey("userID" , equalTo: PFUser.current()!)
    
        query.findObjectsInBackground { (teams, error) in
            if teams != nil {
                self.teams = teams!
                self.teamTableView.reloadData()
                self.myRefreshControl.endRefreshing()
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
        
        let spriteArray = team["pokeSprites"] as! [String]
        cell.pokeOneImage.image = UIImage(named: (spriteArray[0] + ".png"))
        cell.pokeTwoImage.image = UIImage(named: (spriteArray[1] + ".png"))
        cell.pokeThreeImage.image = UIImage(named: (spriteArray[2] + ".png"))
        cell.pokeFourImage.image = UIImage(named: (spriteArray[3] + ".png"))
        cell.pokeFiveImage.image = UIImage(named: (spriteArray[4] + ".png"))
        cell.pokeSixImage.image = UIImage(named: (spriteArray[5] + ".png"))
        
        cell.imageShare = UIImage(named: (spriteArray[0] + ".png"))
        cell.viewTeamBtn.tag = indexPath.row
        cell.shareBtn.tag = indexPath.row
       
        
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "teamViewSegue") {
            let index = (sender as! UIButton).tag
            let team = teams[index]
            
            let destination = segue.destination as! TeamViewController
            
            destination.team = team
        }
    }
}
