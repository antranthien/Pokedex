//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by admin on 05/11/16.
//  Copyright © 2016 An Tran Thien. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name
        mainImage.image = img
        currentEvolutionImage.image = img
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        baseAttackLbl.text = pokemon.baseAttack
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        defenseLbl.text = pokemon.defense
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if let nextEvolution = pokemon.nextEvolition {
            nextEvolutionImage.isHidden = false
            nextEvolutionImage.image = UIImage(named: "\(nextEvolution.pokedexId)")
            nextEvolutionLbl.text = "Next evolution: \(nextEvolution.name)"
        }
        else {
            nextEvolutionLbl.text = "No evolution"
            nextEvolutionImage.isHidden = true
        }
    }
}
