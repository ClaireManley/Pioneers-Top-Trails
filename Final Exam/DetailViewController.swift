//
//  DetailViewController.swift
//  Final Exam
//
//  Created by Claire Manley on 4/27/20.
//  Copyright © 2020 Claire Manley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pokemon == nil {
            pokemon = Pokemon(name: "", url: "")
        }
        nameLabel.text = pokemon.name
        heightLabel.text = ""
        weightLabel.text = ""
        baseExperienceLabel.text = ""
        
        updateUserInterface()

    }
    
    func updateUserInterface() {
             let pokeDetail = PokeDetail()
           pokeDetail.url = pokemon.url
           //pass pokemon url that goes to the detail page to Pokedetail
           pokeDetail.getData {
               DispatchQueue.main.async {
                   self.weightLabel.text = "\(pokeDetail.weight)"
                   self.heightLabel.text = "\(pokeDetail.height)"
                   self.baseExperienceLabel.text = "\(pokeDetail.base_experience)"
                   
                   // get and display image
                //first check to see valid image
                guard let url = URL(string: pokeDetail.imageURL) else {
                self.imageView.image = UIImage(systemName: "blank.profile.image")
                return
               }
                do {
                    let data = try Data(contentsOf: url)
                    self.imageView.image = UIImage(data: data)
                } catch {
                    print("ERROR: error thrown trying to get image from URL \(url)")
                    
                }
           }
    }
}
}
