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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // any and all things here are placeholders.
        // i will refer to https://www.youtube.com/watch?v=BTKhVkcezBk to do this stuff
        switch pickerView.tag {
        case 1:
            return 1 // move 1
        case 2:
            return 1 // move 2
        case 3:
            return 1 // move 3
        case 4:
            return 1 // move 4
        case 5:
            return 1 // ability
        case 6:
            return 1 // nature
        case 7:
            return 1 // gender
        case 8:
            return 1 // item
        default:
            return 1
        }
    }
    
    
    var genders: [String] = ["Male", "Female"]
    
    // data passed from the previous view controller
    var pokemonName: String = ""
    var pokemonId: Int = -1
    var abilityArray: [String] = [String]()
    var moveArray: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // to prove that data was passed through
        print(self.pokemonName)
        print(self.moveArray)
        
        // fetch natures
        
        var natureArray: [String] = [String]()
        
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
                            
                            natureArray.append(nature["name"]!)
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
