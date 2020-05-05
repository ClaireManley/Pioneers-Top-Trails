//
//  DetailViewController.swift
//  Final Exam
//
//  Created by Claire Manley on 4/27/20.
//  Copyright © 2020 Claire Manley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var trail: Trail!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if trail == nil {
            trail = Trail!(name: "", url: "")
        }
        label1.text = trail.name
        nameLabel.text = ""
        locationLabel.text = ""
        lengthLabel.text = ""
        
        updateUserInterface()

    }
    
    func updateUserInterface() {
             let trailDetail = TrailDetail()
           trailDetail.url = trail.url
           //pass pokemon url that goes to the detail page to Pokedetail
           trailDetail.getData {
               DispatchQueue.main.async {
                   self.locationLabel.text = "\(trailDetail.location)"
                   self.nameLabel.text = "\(trailDetail.name)"
                   self.lengthLabel.text = "\(trailDetail.length)"
                   
                   // get and display image
                //first check to see valid image
                guard let url = URL(string: trailDetail.imageURL) else {
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
