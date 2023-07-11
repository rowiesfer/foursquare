//
//  PlaceListClientStub.swift
//  PlaceList
//
//  Created by Fer on 14/07/2023.
//

import Foundation
import FoursquareAPI

class PlaceListClientStub: FoursquareClientProtocol {
    func send(foursquareRequest: FoursquareAPI.FoursquareRequest) async throws -> Data {
        return try Data(contentsOf: Bundle(for: PlaceListClientStub.self).url(forResource: "PlaceSearchResponse", withExtension: "json")!)
    }
}
