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
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
        
        pokemon.downloadPokemonDetail {
            DispatchQueue.main.async {
                self.updateUI()
            }
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
    }
}
