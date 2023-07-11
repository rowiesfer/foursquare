//
//  PlaceListFactory.swift
//  PlaceList
//
//  Created by Fer on 14/07/2023.
//

import Foundation
import FoursquareAPI

public struct PlaceListFactory {
    
    public init() {}
    
    // Poor man's dependency injection. This should def be improved in a real project, using a dependency injection framework like Swinject would already help.
    @MainActor public func newPlaceList(apiBaseUrl: URL, apiKey: String) -> PlaceListView {
        return PlaceListView(viewModel: PlaceListViewModel(repository: PlaceListRepository(client: FoursquareClient(baseUrl: apiBaseUrl, key: apiKey))))
    }
    
    // Internal factory method to be used for previews with mocked data
    @MainActor func newPlaceListMocked() -> PlaceListView {
        return PlaceListView(viewModel: PlaceListViewModel(repository: PlaceListRepository(client: PlaceListClientStub())))
    }
}


