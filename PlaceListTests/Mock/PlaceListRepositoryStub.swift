//
//  PlaceListRepositoryStub.swift
//  PlaceListTests
//
//  Created by Fer on 14/07/2023.
//

import Foundation

// Poor man's stubbing for the unit test examples.
class PlaceListRepositoryStub: PlaceListRepositoryProtocol {
    
    var stubPlaceList: [Place]
    var error: Error? = nil
    
    init() {
        self.stubPlaceList = []
    }
    
    init(stubPlaceList: [Place]) {
        self.stubPlaceList = stubPlaceList
    }
    
    func getPlaces() async throws -> [Place] {
        guard self.error == nil else {
            throw error!
        }
        
        return self.stubPlaceList
    }
}
