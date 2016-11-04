//
//  PokeCell.swift
//  Pokedex
//
//  Created by admin on 04/11/16.
//  Copyright © 2016 An Tran Thien. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeNameLbl: UILabel!
    
    func configureCell(pokemon: Pokemon){
        pokeNameLbl.text = pokemon.name.capitalized
        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
    }
}
