//
//  FoursquareAPIProtocol.swift
//  foursquare-api
//
//  Created by Fer on 12/07/2023.
//

import Foundation

public protocol FoursquareClientProtocol {
    func send(foursquareRequest: FoursquareRequest) async throws -> Data
}

public enum FoursquareClientError: Error, LocalizedError {
    case networkError(httpResponse: HTTPURLResponse, data: Data)
    case unableToParseResponse
}
