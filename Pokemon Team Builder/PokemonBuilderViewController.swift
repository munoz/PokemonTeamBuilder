//
//  PokemonBuilderViewController.swift
//  Pokemon Team Builder
//
//  Created by user180091 on 11/30/20.
//  Copyright © 2020 munoz. All rights reserved.
//

import UIKit
import Parse
import PokemonAPI

class PokemonBuilderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let pokemon = PFObject(className: "Pokemon")
    
    @IBOutlet weak var move1TextField: UITextField!
    @IBOutlet weak var move2TextField: UITextField!
    @IBOutlet weak var move3TextField: UITextField!
    @IBOutlet weak var move4TextField: UITextField!
    @IBOutlet weak var abilityTextField: UITextField!
    @IBOutlet weak var natureTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    
    var move1PickerView = UIPickerView()
    var move2PickerView = UIPickerView()
    var move3PickerView = UIPickerView()
    var move4PickerView = UIPickerView()
    var abilityPickerView = UIPickerView()
    var naturePickerView = UIPickerView()
    var genderPickerView = UIPickerView()
    var itemPickerView = UIPickerView()
    
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
        
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSaveTouch(_ sender: Any) {
        
        if checkMoves() {
            if checkDuplicateMoves() {
                if checkANG().0 {
                    
                    pokemon["moveset"] = [move1TextField.text, move2TextField.text, move3TextField.text, move4TextField.text]
                    pokemon["ability"] = abilityTextField.text
                    pokemon["nature"] = natureTextField.text
                    pokemon["gender"] = genderTextField.text
                    pokemon["item"] = itemTextField.text
                    pokemon["pokeID"] = String(pokemonId)
                    pokemon["teamID"] = team
                    
                    var updateSprites = self.team["pokeSprites"] as! [String]
                    updateSprites[pokemonPlaceInTeam] = String(pokemonId)
                    self.team["pokeSprites"] = updateSprites
                    
                    self.pokemon.saveInBackground { (success, error) in
                        if success {
                            self.performSegue(withIdentifier: "contTeamBuilderSegue", sender: nil)
                            print("saved!")
                        } else {
                            print("error!")
                        }
                    }
                    
                } else {
                    self.showToast(message: "Please Select \(checkANG().1)!", font: .systemFont(ofSize: 12.0))
                }
            } else {
                self.showToast(message: "No Duplicate Moves!", font: .systemFont(ofSize: 12.0))
            }
        } else {
            self.showToast(message: "Select at least one Move!", font: .systemFont(ofSize: 12.0))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TeamBuilderViewController
        
        destination.team = self.team

    }
    
    // Checks that at least one move was chosen
    func checkMoves() -> Bool {
        if move1TextField.text == "" && move2TextField.text == "" && move3TextField.text == "" && move4TextField.text == "" {
            return false
        } else if move1TextField.text != "" || move2TextField.text != "" || move3TextField.text != "" || move4TextField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    // Checks that no two same moves are chosen
    func checkDuplicateMoves() -> Bool {
        var moves = [String]()
        
        if move1TextField.text != "" {
            moves.append(move1TextField.text ?? "not move")
        }
        
        if move2TextField.text != "" {
            moves.append(move2TextField.text ?? "not move")
        }
        
        if move3TextField.text != "" {
            moves.append(move3TextField.text ?? "not move")
        }
        
        if move4TextField.text != "" {
            moves.append(move4TextField.text ?? "not move")
        }
        
        return moves.count == Set(moves).count
    }
    
    // Checks for no empty Ability, Nature, and Gender
    func checkANG() -> (Bool, String) {
        if abilityTextField.text == "" {
            return (false, "Ability")
        }
        
        if natureTextField.text == "" {
            return (false, "Nature")
        }
        
        if genderTextField.text == "" {
            return (false, "Gender")
        }
        return (true, "Pass")
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // source: https://www.youtube.com/watch?v=BTKhVkcezBk
        switch pickerView.tag {
        case 1:
            return moveArray.count // move 1
        case 2:
            return moveArray.count // move 2
        case 3:
            return moveArray.count // move 3
        case 4:
            return moveArray.count // move 4
        case 5:
            return abilityArray.count // ability
        case 6:
            return natureArray.count // nature
        case 7:
            return genders.count // gender
        case 8:
            return items.count // item
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return moveArray[row] // move 1
        case 2:
            return moveArray[row] // move 2
        case 3:
            return moveArray[row] // move 3
        case 4:
            return moveArray[row] // move 4
        case 5:
            return abilityArray[row] // ability
        case 6:
            return natureArray[row] // nature
        case 7:
            return genders[row] // gender
        case 8:
            return items[row]["itemName"] as? String // item
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            move1TextField.text = moveArray[row] // move 1
            move1TextField.resignFirstResponder()
        case 2:
            move2TextField.text = moveArray[row] // move 2
            move2TextField.resignFirstResponder()
        case 3:
            move3TextField.text = moveArray[row] // move 3
            move3TextField.resignFirstResponder()
        case 4:
            move4TextField.text = moveArray[row] // move 4
            move4TextField.resignFirstResponder()
        case 5:
            abilityTextField.text = abilityArray[row] // ability
            abilityTextField.resignFirstResponder()
        case 6:
            natureTextField.text = natureArray[row] // nature
            natureTextField.resignFirstResponder()
        case 7:
            genderTextField.text = genders[row] // gender
            genderTextField.resignFirstResponder()
        case 8:
            itemTextField.text = items[row]["itemName"] as? String // item
            itemTextField.resignFirstResponder()
        default:
            return
        }
    }
    

    var genders: [String] = ["Male", "Female"]
    
    // data passed from the previous view controller
    var pokemonName: String = ""
    var pokemonId: Int = -1
    var abilityArray: [String] = [String]()
    var moveArray: [String] = [String]()
    var team = PFObject(className: "Team")
    var pokemonPlaceInTeam: Int = -1
    
    var natureArray: [String] = [String]()
    
    var items = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupHideKeyboardOnTap()

        
        // to prove that data was passed through
        print(self.pokemonName)
        print(self.moveArray)
        
        // fetch natures
        
        
        
        PokemonAPI().pokemonService.fetchNatureList(paginationState: .initial(pageLimit: 25)) { result in
            switch result {
            case .success(let pagedNatures):
                print("\(pagedNatures.count!)") // 25
                print(pagedNatures.current)
                
                // get natures json
                
                do {
                    if let file = URL(string: pagedNatures.current) {
                        let data = try Data(contentsOf: file)
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        // extract nature from json
                        
                        let object = json as? [String: Any]
                        
                        let result = object?["results"] as! [Any]
                        
                        // push into natures array
                        for i in 0..<25 {
                            let nature = result[i] as! [String: String]
                            
                            self.natureArray.append(nature["name"]!)
                        }
                    } else {
                       print("no file")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        move1TextField.inputView = move1PickerView
        move2TextField.inputView = move2PickerView
        move3TextField.inputView = move3PickerView
        move4TextField.inputView = move4PickerView
        abilityTextField.inputView = abilityPickerView
        natureTextField.inputView = naturePickerView
        genderTextField.inputView = genderPickerView
        itemTextField.inputView = itemPickerView
        
        move1TextField.placeholder = "Move 1"
        move2TextField.placeholder = "Move 2"
        move3TextField.placeholder = "Move 3"
        move4TextField.placeholder = "Move 4"
        abilityTextField.placeholder = "Ability"
        natureTextField.placeholder = "Nature"
        genderTextField.placeholder = "Gender"
        itemTextField.placeholder = "Item"
        
        move1PickerView.delegate = self
        move2PickerView.delegate = self
        move3PickerView.delegate = self
        move4PickerView.delegate = self
        abilityPickerView.delegate = self
        naturePickerView.delegate = self
        genderPickerView.delegate = self
        itemPickerView.delegate = self
        
        move1PickerView.dataSource = self
        move2PickerView.dataSource = self
        move3PickerView.dataSource = self
        move4PickerView.dataSource = self
        abilityPickerView.dataSource = self
        naturePickerView.dataSource = self
        genderPickerView.dataSource = self
        itemPickerView.dataSource = self
        
        move1PickerView.tag = 1
        move2PickerView.tag = 2
        move3PickerView.tag = 3
        move4PickerView.tag = 4
        abilityPickerView.tag = 5
        naturePickerView.tag = 6
        genderPickerView.tag = 7
        itemPickerView.tag = 8
        
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Items")
        query.includeKey("itemName")
        query.limit = 187
        query.findObjectsInBackground { (items, error) in
            if items != nil {
                self.items = items!
            }
        }
        
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
