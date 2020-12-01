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
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // any and all things here are placeholders.
        // i will refer to https://www.youtube.com/watch?v=BTKhVkcezBk to do this stuff
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
            return 1 // item
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
            return "curently a placeholder" // item
        default:
            return "Data not found."
        }
    }
    
    
    var genders: [String] = ["Male", "Female"]
    
    // data passed from the previous view controller
    var pokemonName: String = ""
    var pokemonId: Int = -1
    var abilityArray: [String] = [String]()
    var moveArray: [String] = [String]()
    
    var natureArray: [String] = [String]()
    
    var items = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        
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
        
        
        
        
        /*
        // fetch items
        
        var itemArray: [String] = [String]()
        
        PokemonAPI().itemService.fetchItemList(paginationState: .initial(pageLimit: 954)) { result in
            switch result {
            case .success(let pagedItems):
                print("\(pagedItems.count!)")
                print(pagedItems.current)
                
                // get natures json
                
                do {
                    if let file = URL(string: pagedItems.current) {
                        let data = try Data(contentsOf: file)
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        // extract nature from json
                        
                        let object = json as? [String: Any]
                        
                        let result = object?["results"] as! [Any]
                        
                        // push into items array
                        for i in 0..<25 {
                            let item = result[i] as! [String: String]
                            
                            itemArray.append(item["name"]!)
                        }
                        
                        print(itemArray[0])
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
        */



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
