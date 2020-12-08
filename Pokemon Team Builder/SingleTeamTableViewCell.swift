//
//  SingleTeamTableViewCell.swift
//  Pokemon Team Builder
//
//  Created by user180060 on 12/7/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit

class SingleTeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var moveOneLabel: UILabel!
    @IBOutlet weak var moveTwoLabel: UILabel!
    @IBOutlet weak var moveThreeLabel: UILabel!
    @IBOutlet weak var moveFourLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var natureLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
