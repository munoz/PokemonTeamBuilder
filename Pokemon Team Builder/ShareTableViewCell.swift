//
//  ShareTableViewCell.swift
//  Pokemon Team Builder
//
//  Created by Blayne Suttonwills on 12/3/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit

class ShareTableViewCell: UITableViewCell {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBAction func shareTeamButton(_ sender: Any) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
