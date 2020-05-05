//
//  PokemonData.swift
//  Final Exam
//
//  Created by Claire Manley on 4/27/20.
//  Copyright © 2020 Claire Manley. All rights reserved.
//

import Foundation

class TrailData {
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Trail]
        
    }
    var count = 0
    var url = "https://www.trailrunproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10&key=200747983-8b9b590ebe38cbd1bd26c730bfab2cca"
    var trailArray: [Trail] = []
    
    func getData(completed: @escaping ()->()) {
        let urlString = url
        print("🕸 We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // Get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            // note: there are some additional things that could go wrong when using URL session, but we shouldn't experience them, so we'll ignore testing for these for now...
            
            // deal with the data
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.count = returned.count
                self.url = returned.next
                self.trailArray = self.trailArray + returned.results
                
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}
    

