//
//  SignUpViewController.swift
//  Pokemon Team Builder
//
//  Created by studentProfile on 11/5/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var newUsernameField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    
    @IBAction func onCreateAccount(_ sender: Any) {
        let user = PFUser()
        user.username = newUsernameField.text
        user.password = newPasswordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                //need to create main page then login segue
                self.performSegue(withIdentifier: "signupTabSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
