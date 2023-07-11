//
//  PlaceListViewState.swift
//  foursquare
//
//  Created by Fer on 13/07/2023.
//

import Foundation

struct PlaceListViewState {

    enum LoadingState {
        case loading
        case error
        case success
    }
    
    struct PlaceViewData: Identifiable {
        let id: String
        let title: String
        let subtitle: String
        let address: String
    }

    let loadingState: LoadingState
    let sliderText: String
    var messageText: String = ""
    var places: [PlaceViewData] = []
}
