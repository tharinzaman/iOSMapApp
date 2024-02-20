//
//  NetworkClientImpl.swift
//  MapApp
//
//  Created by Tharin Zaman on 20/02/2024.
//

import Foundation
import Combine

final class NetworkClientImpl: NetworkClientProtocol {
    
    private let baseURL = "https://api.3geonames.org/"
    private let randomUKLandEndpoint = "randomland.UK.json"
    
    func fetch(
        session: URLSession = .shared
    ) async throws -> RandomLocation {
        
        guard let url = URL(
            string: baseURL + randomUKLandEndpoint
        ) else {
            throw URLError(
                .badURL
            )
        }
        
        let (
            data,
            response
        ) = try await session.data(
            from: url
        )
        
        guard (
            response as? HTTPURLResponse
        )?.statusCode == 200 else {
            throw URLError(
                .badServerResponse
            )
        }
        
        do {
            return try JSONDecoder().decode(
                RandomLocationModel.self,
                from: data
            ).location
        } catch {
            // TODO: Change this to a custom error
            throw URLError(.badServerResponse)
        }
    }
    
    func fetchWithCombine() throws -> AnyPublisher<RandomLocationModel, Error> {
        
        guard let url = URL(
            string: baseURL + randomUKLandEndpoint
        ) else {
            throw URLError(
                .badURL
            )
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map( {$0.data} )
            .decode(type: RandomLocationModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
