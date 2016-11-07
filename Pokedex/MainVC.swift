//
//  ViewController.swift
//  Pokedex
//
//  Created by admin on 02/11/16.
//  Copyright © 2016 An Tran Thien. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {

    
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var isInSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.returnKeyType = .done
        parsePokemonCSV()
        
        //initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            
            // Loop infinitely
            musicPlayer.numberOfLoops = -1
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]
                
                let pokemon = Pokemon(name: name!, pokedexId: pokeId!)
                pokemons.append(pokemon)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    @IBAction func btnMusicPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let destination = segue.destination as? PokemonDetailVC {
                if let pokemon = sender as? Pokemon {
                    destination.pokemon = pokemon
                }
            }
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            
            pokemon = isInSearchMode ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
            
            cell.configureCell(pokemon)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = isInSearchMode ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInSearchMode ? filteredPokemons.count : pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
}

extension MainVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            view.endEditing(true)
        }
        else {
            isInSearchMode = true
            
            let searchText = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: searchText) != nil})
            
        }
        
        pokeCollectionView.reloadData()
    }
}
