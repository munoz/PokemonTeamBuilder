//
//  TeamTableViewCell.swift
//  Pokemon Team Builder
//
//  Created by user180060 on 11/30/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeOneImage: UIImageView!
    @IBOutlet weak var pokeTwoImage: UIImageView!
    @IBOutlet weak var pokeThreeImage: UIImageView!
    @IBOutlet weak var pokeFourImage: UIImageView!
    @IBOutlet weak var pokeFiveImage: UIImageView!
    @IBOutlet weak var pokeSixImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var viewTeamBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onShareTouch(_ sender: UIButton) {
        
        let str = "Check out my Pokémon team " + teamNameLabel.text!
        let vc = UIActivityViewController(activityItems:[str, pokeOneImage as Any], applicationActivities: nil)
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
