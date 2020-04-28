//
//  ViewController.swift
//  Final Exam
//
//  Created by Claire Manley on 4/27/20.
//  Copyright © 2020 Claire Manley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    //datasource + delegate!
    
 //   var pokeArray = ["Bulbasaur", "Pikachu", "Snorlax", "Wigglytuff", "Charmander"]
    var pokemonData = PokemonData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        pokemonData.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSegue" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.pokemon = pokemonData.pokeArray[selectedIndexPath.row]
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // return pokeArray.count
    return pokemonData.pokeArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    //remember, arrays + index paths are zero-indexed, so need to indexPath.row + 1
    cell.textLabel?.text = "\(indexPath.row + 1). \(pokemonData.pokeArray[indexPath.row].name)"
    return cell
    
}

}
