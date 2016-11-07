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
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _baseAttack: String!
    fileprivate var _nextEvolutionTxt: String!
    fileprivate var _pokemonURL: String!
    
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
            }
            
            completed()
        }
    }
}
