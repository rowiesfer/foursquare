//
//  foursquareApp.swift
//  foursquare
//
//  Created by Fer on 11/07/2023.
//

import SwiftUI
import PlaceList

@main
struct foursquareApp: App {

    // This would normally come from config files, just added them here for the sake of simplicity
    private let foursquareURL = URL(string: "https://api.foursquare.com/v3")!
    private let key = "fsq3HL26vthmrVfGMkDLmaIZaypNjxDRFT0nL55Tkd1AKPg="

    var body: some Scene {
        WindowGroup {
            PlaceListFactory().newPlaceList(apiBaseUrl: foursquareURL, apiKey: key)
        }
    }
}
