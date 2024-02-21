//
//  NetworkClientProtocol.swift
//  MapApp
//
//  Created by Tharin Zaman on 20/02/2024.
//

import Foundation
import Combine

protocol NetworkClientProtocol {
    
    func fetch(
        session: URLSession
    ) async throws -> RandomLocation
    
    func fetchWithCombine() throws -> AnyPublisher<RandomLocationModel, Error>
    
}
