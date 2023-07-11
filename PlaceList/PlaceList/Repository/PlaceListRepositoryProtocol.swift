//
//  PlaceListRepositoryProtocol.swift
//  foursquare
//
//  Created by Fer on 13/07/2023.
//

import Foundation

protocol PlaceListRepositoryProtocol {
    func getPlaces() async throws -> [Place]
}
