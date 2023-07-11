//
//  PlaceListView.swift
//  foursquare
//
//  Created by Fer on 13/07/2023.
//

import Foundation
import SwiftUI

public struct PlaceListView: View {

    @ObservedObject var viewModel: PlaceListViewModel
    
    @State private var radius = 5.0

    init(viewModel: PlaceListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        
        VStack {
            Text("Places")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Around you...")
                .font(.caption)
                .fontWeight(.bold)
            
            HStack {
                Slider(
                    value: $radius,
                    in: 1...50,
                    onEditingChanged: { editing in
                        if editing == false {
                            viewModel.fetchPlaces(radius: radius)
                        }
                    }
                )
                .padding(.horizontal)
                
                Text(viewModel.viewState.sliderText)
                    .padding(.horizontal)
            }

            Spacer()
            
            switch viewModel.viewState.loadingState {
            case .loading:
                Text(viewModel.viewState.messageText)
            case .error:
                Text(viewModel.viewState.messageText)
            case .success:
                List {
                    ForEach(viewModel.viewState.places) { place in
                        VStack{
                            HStack{
                                Text(place.title)
                                    .font(.headline)
                                Spacer()
                            }
                            HStack{
                                Text(place.subtitle)
                                    .font(.subheadline)
                                    .padding(.bottom)
                                Spacer()
                            }
                            HStack{
                                Text(place.address)
                                    .font(.footnote)
                                Spacer()
                            }
                        }
                        
                    }
                }.refreshable {
                    viewModel.refreshPlaces(radius: radius)
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchPlaces(radius: radius)
        }
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListFactory().newPlaceListMocked()
    }
}
