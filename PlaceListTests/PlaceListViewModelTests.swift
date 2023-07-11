//
//  PlaceListViewModelTests.swift
//  PlaceListTests
//
//  Created by Fer on 14/07/2023.
//

import XCTest
import Nimble

final class PlaceListViewModelTests: XCTestCase {

    var viewModel: PlaceListViewModel!
    
    @MainActor override func setUpWithError() throws {
        viewModel = PlaceListViewModel(repository: PlaceListRepositoryStub())
    }

    @MainActor func testViewModelLoadingSate_whenFetchPlacesIsCalled_isSetToLoading() throws {
        // Arrange
        viewModel = PlaceListViewModel(repository: PlaceListRepositoryStub())
        
        // Act
        viewModel.fetchPlaces(radius: 5.0)
        
        // Assert
        XCTAssertEqual(viewModel.viewState.loadingState, .loading)
    }
    
    @MainActor func testViewModelLoadingSate_whenFetchPlacesSuccessfullyRetrievesData_isSetToSuccess() async throws {
        // Arrange
        viewModel = PlaceListViewModel(repository: PlaceListRepositoryStub())
        
        // Act
        viewModel.fetchPlaces(radius: 5.0)
                
        // Assert
        await expect(self.viewModel.viewState.loadingState).toEventually(equal(.success))
    }
    
    @MainActor func testViewModelLoadingSate_whenFetchPlacesSuccessfullyRetrievesData_hasValidPlace() throws {
        // Arrange
        let testPlace: Place = .init(id: "1",
                              name: "Restaurant",
                              location: .init(address: "Nolensstraat 123",
                                              formattedAddress: "Nolensstraat 123, 3039PK"),
                              categories: [
                                .init(id: 1, name: "Spanish restaurant")
                              ])
        viewModel = PlaceListViewModel(repository: PlaceListRepositoryStub(stubPlaceList: [testPlace]))

        // Act
        viewModel.fetchPlaces(radius: 5.0)
        
        // Assert
        expect(self.viewModel.viewState.places.first).toEventuallyNot(beNil())
        expect(self.viewModel.viewState.places.first!.id).toEventually(equal(testPlace.id))
    }
    
    @MainActor func testViewModelLoadingSate_whenFetchPlacesThrowsError_isSetToError() async throws {
        // Arrange
        let placeListRepositoryStub = PlaceListRepositoryStub()
        placeListRepositoryStub.error = NSError()
        viewModel = PlaceListViewModel(repository: placeListRepositoryStub)
        
        // Act
        viewModel.fetchPlaces(radius: 5.0)
        
        // Assert
        await expect(self.viewModel.viewState.loadingState).toEventually(equal(.error))
    }
    
    // In here other tests like these should be added for the formatting of the slider label, the mapping of the places to view data, etc...
    // Those would be really similar to the ones above.

}
