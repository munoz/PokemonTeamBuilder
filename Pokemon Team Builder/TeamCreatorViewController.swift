//
//  TeamCreatorViewController.swift
//  Pokemon Team Builder
//
//  Created by user180060 on 12/1/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse

class TeamCreatorViewController: UIViewController {
    
    @IBOutlet weak var teamNameLabel: UITextField!
    
    let team = PFObject(className: "Team")
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupHideKeyboardOnTap()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreateButton(_ sender: Any) {
        
        if teamNameLabel.text == "" {
            self.showToast(message: "Please enter a name!", font: .systemFont(ofSize: 12.0))
        } else {
            

            self.team["teamName"] = teamNameLabel.text
            self.team["pokeSprites"] = ["0", "0", "0", "0", "0", "0"]
            self.team["userID"] = PFUser.current()!

            self.team.saveInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "buildSegue", sender: nil)
                    print("saved!")
                } else {
                    print("error!")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TeamBuilderViewController
        
        destination.team = self.team

    }
    
    // Source: https://stackoverflow.com/questions/31540375/how-to-toast-message-in-swift
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
