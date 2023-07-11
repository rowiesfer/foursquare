//
//  Location.swift
//  PlaceList
//
//  Created by Fer on 14/07/2023.
//

import Foundation

struct Location: Codable {
    let address: String
    let formattedAddress: String
    
    private enum CodingKeys : String, CodingKey {
        case address, formattedAddress = "formatted_address"
    }
}
