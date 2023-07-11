//
//  PlaceListViewModel.swift
//  foursquare
//
//  Created by Fer on 13/07/2023.
//

import Foundation

@MainActor class PlaceListViewModel: ObservableObject {
    
    private let repository: PlaceListRepositoryProtocol
    
    init(repository: PlaceListRepositoryProtocol) {
        self.repository = repository
    }
    
    @Published var viewState: PlaceListViewState = .init(loadingState: .loading,
                                                         sliderText: "-")
    
    func fetchPlaces(radius: Double) {
        viewState = .init(loadingState: .loading,
                          sliderText: formattedSliderLabel(value: radius),
                          messageText: "Loading...")
        refreshPlaces(radius: radius)
    }

    func refreshPlaces(radius: Double) {
        Task.init {
            do {
                let places = try await repository.getPlaces()
                viewState = .init(loadingState: .success,
                                  sliderText: formattedSliderLabel(value: radius),
                                  places: mapPlacesToViewData(places))
            } catch {
                viewState = .init(loadingState: .error,
                                  sliderText: formattedSliderLabel(value: radius),
                                  messageText: "Oh oh, something went wrong!")
            }
        }
    }
    
    func formattedSliderLabel(value: Double) -> String {
        return String(format:"%.1f", value) + " KMs"
    }
    
    func mapPlacesToViewData(_ places: [Place]) -> [PlaceListViewState.PlaceViewData] {
        let placesViewData = places.map { place in
            let categoryNames: [String] = place.categories.map { $0.name }
            let subtitle = categoryNames.joined(separator: ", ")
            
            return PlaceListViewState.PlaceViewData(id: place.id ,
                                                    title: place.name,
                                                    subtitle: subtitle,
                                                    address: "Address: \(place.location.address)")
        }
        
        return placesViewData
    }
}
