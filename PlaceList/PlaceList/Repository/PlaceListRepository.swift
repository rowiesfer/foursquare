//
//  PlaceListRepository.swift
//  foursquare
//
//  Created by Fer on 13/07/2023.
//

import Foundation
import FoursquareAPI

class PlaceListRepository: PlaceListRepositoryProtocol {

    private let client: FoursquareClientProtocol

    private struct PlaceSearchRequest: FoursquareRequest {
        let httpMethod = "GET"
        let path = "/places/search"
        var parameters: [String : String] = [:]
    }

    init(client: FoursquareClientProtocol) {
        self.client = client
    }

    func getPlaces() async throws -> [Place] {
        let placesData = try await client.send(foursquareRequest: PlaceSearchRequest())
        let placeResponse = try JSONDecoder().decode(PlaceResponse.self, from: placesData)
        return placeResponse.results
    }
}
