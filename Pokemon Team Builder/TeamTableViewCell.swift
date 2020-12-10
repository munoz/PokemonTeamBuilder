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
    
    @IBAction func onShareTouch(_ sender: UIButton) {
        var shareImages = [Any]()
        
        let text = "Check out my Pokémon team " + teamNameLabel.text!
        shareImages.append(text)
        
        if pokeOneImage.image != UIImage(named: "0.png"){
            shareImages.append(pokeOneImage.image!)
        }
        if pokeTwoImage.image != UIImage(named: "0.png"){
            print("added")
            shareImages.append(pokeTwoImage.image!)
        }
        if pokeThreeImage.image != UIImage(named: "0.png"){
            shareImages.append(pokeThreeImage.image!)
        }
        if pokeFourImage.image != UIImage(named: "0.png"){
            shareImages.append(pokeFourImage.image!)
        }
        if pokeFiveImage.image != UIImage(named: "0.png"){
            shareImages.append(pokeFiveImage.image!)
        }
        if pokeSixImage.image != UIImage(named: "0.png"){
            shareImages.append(pokeSixImage.image!)
        }
        
        let vc = UIActivityViewController(activityItems:shareImages, applicationActivities: nil)
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
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
