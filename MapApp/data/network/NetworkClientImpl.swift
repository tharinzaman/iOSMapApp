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
            throw NetworkError.invalidURL
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
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(
                RandomLocationModel.self,
                from: data
            ).location
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func fetchWithCombine() throws -> AnyPublisher<RandomLocationModel, Error> {
        
        guard let url = URL(
            string: baseURL + randomUKLandEndpoint
        ) else {
            throw NetworkError.invalidURL
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
