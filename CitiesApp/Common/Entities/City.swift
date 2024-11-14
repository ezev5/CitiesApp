//
//  City.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation

struct City: Codable, Identifiable, Hashable {
  let country: String
  let name: String
  let id: Int
  let coordinates: Coordinates
  
  var displayableName: String {
    return name + ", " + country
  }
  
  enum CodingKeys: String, CodingKey {
    case country
    case name
    case id = "_id"
    case coordinates = "coord"
  }
}


struct Coordinates: Codable, Hashable {
  let longitude: Double
  let latitude: Double
  
  enum CodingKeys: String, CodingKey {
    case longitude = "lon"
    case latitude = "lat"
  }
}
