//
//  ProfileViewController.swift
//  Pokemon Team Builder
//
//  Created by Blayne Suttonwills on 12/6/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import PokemonAPI

class ProfileViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        sceneDelegate.window?.rootViewController = loginViewController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        PokemonAPI().pokemonService.fetchPokemon(searchBar.text?.lowercased() ?? "") { result in

            DispatchQueue.main.async {
                if (self.searchBar.text != "") {

                    switch result {
                    case .success(let pokemon):
                        let currentUser = PFUser.current()!
                        currentUser["favoritePoke"] = String(pokemon.id!) + ".png"
                        
                        currentUser.saveInBackground { (success, error) in
                            if success {
                                print("saved!")
                            } else {
                                print("error!")
                            }
                        }
                        
                        self.profileImage.image = UIImage(named: (String(pokemon.id!) + ".png"))
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.showToast(message: "Pokemon not fonud!", font: .systemFont(ofSize: 12.0))
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        let currentUser = PFUser.current()!
        usernameLabel.text = currentUser["username"] as? String
        let favoriteMon = currentUser["favoritePoke"] as? String ?? "0.png"
        self.profileImage.image = UIImage(named: favoriteMon)
        
        self.setupHideKeyboardOnTap()
    }
    
    // Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-400, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
