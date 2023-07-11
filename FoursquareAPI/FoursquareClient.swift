//
//  FoursquareClient.swift
//  foursquare-api
//
//  Created by Fer on 12/07/2023.
//

import Foundation

public protocol FoursquareRequest {
    var httpMethod: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

public class FoursquareClient: FoursquareClientProtocol {

    private let baseUrl: URL
    private let key: String
    
    public init(baseUrl: URL, key: String) {
        self.baseUrl = baseUrl
        self.key = key
    }
    
    public func send(foursquareRequest: FoursquareRequest) async throws -> Data {
        
        var request = URLRequest(url: baseUrl.appending(path: foursquareRequest.path))
        request.httpMethod = foursquareRequest.httpMethod
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": key
        ]

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw FoursquareClientError.unableToParseResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw FoursquareClientError.networkError(httpResponse: httpResponse, data: data)
        }

        return data
    }

}
