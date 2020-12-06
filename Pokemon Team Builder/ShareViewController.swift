//
//  ShareViewController.swift
//  Pokemon Team Builder
//
//  Created by Blayne Suttonwills on 12/6/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ShareViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var shareTableView: UITableView!
    
    var teams = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareTableView.dataSource = self
        shareTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentUser = PFUser.current()
        let currentID = PFUser.current()!["userID"] as? String ?? "userID"
        
        let query = PFQuery(className: "Team")
        query.includeKey(currentID)
    
        query.findObjectsInBackground { (teams, error) in
            if teams != nil {
                self.teams = teams!
                self.shareTableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shareTeamCell") as! ShareTableViewCell
        let team = teams[indexPath.row]
        
        cell.teamNameLabel.text = team["teamName"] as? String
        
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
