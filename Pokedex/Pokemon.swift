//
//  Pokemon.swift
//  Pokedex
//
//  Created by admin on 02/11/16.
//  Copyright © 2016 An Tran Thien. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String
    fileprivate var _pokedexId: Int
    fileprivate var _type: String = ""
    fileprivate var _defense: String = ""
    fileprivate var _height: String = ""
    fileprivate var _weight: String = ""
    fileprivate var _baseAttack: String = ""
    fileprivate var _nextEvolutionTxt: String = ""
    fileprivate var _pokemonURL: String = ""
    fileprivate var _description: String = ""
    fileprivate var _nextEvolution: Pokemon?
    
    var type: String {
        return _type
    }
    
    var defense: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var baseAttack: String {
        return _baseAttack
    }
    
    var nextEvolutionTxt: String {
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        return _description
    }
    
    var nextEvolition: Pokemon? {
        return _nextEvolution
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId)"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete){
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, Any> {
                if let weight = dict["weight"] as? String {
                    self._weight = String(weight)
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = String(attack)
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    var typesString = ""
                    for i in 0..<types.count {
                        if let name = types[i]["name"] {
                            typesString.append(name.capitalized)
                        }
                        
                        if i != types.count - 1 {
                            typesString.append("/")
                        }
                    }
                    
                    self._type = typesString.capitalized
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    if let url = descriptions[0]["resource_uri"] {
                        let descriptionURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descriptionURL).responseJSON(completionHandler: {(response) in
                            if let descriptionDict = response.result.value as? Dictionary<String, Any> {
                                if let description = descriptionDict["description"] as? String {
                                    self._description = description
                                    print(description)
                                }
                            }
                            completed()
                        })
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        if nextEvolution.range(of: "mega") == nil {
                            let nextEvolutionName = nextEvolution
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                                let nextEvoId = Int(newStr.replacingOccurrences(of: "/", with: ""))
                                
                                self._nextEvolution = Pokemon(name: nextEvolutionName, pokedexId: nextEvoId!)
                            }
                        }
                    }
                }
            }
        }
    }
}
