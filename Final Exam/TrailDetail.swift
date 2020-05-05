//
//  PokeDetail.swift
//  Final Exam
//
//  Created by Claire Manley on 4/27/20.
//  Copyright © 2020 Claire Manley. All rights reserved.
//

import Foundation

class TrailDetail {
    var name = 0.0
    var location = 0.0
    var length = 0.0
    var imageURL = ""
    var url = ""
    
    
    private struct Returned: Codable {
        var name: Double
        var location: Double
        var length: Double
        var sprites: Sprites
        
        
    }
    private struct Sprites: Codable {
        var front_default: String
        
    }
    
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
              
              // deal with the data
              do {
                  let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.name = returned.name
                self.location = returned.location
                self.length = returned.length
                self.imageURL = returned.sprites.front_default
                
              } catch {
                  print("😡 JSON ERROR: \(error.localizedDescription)")
              }
              completed()
          }
          
          task.resume()
      }
}
