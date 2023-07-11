//
//  Place.swift
//  foursquare
//
//  Created by Fer on 13/07/2023.
//

import Foundation

struct Place: Codable, Identifiable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]
    
    private enum CodingKeys : String, CodingKey {
        case id = "fsq_id", name, location, categories
    }
}
