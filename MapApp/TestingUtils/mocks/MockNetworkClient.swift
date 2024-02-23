//
//  MockNetworkClient.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation
import Combine
@testable import MapApp

class MockNetworkClientSuccess: NetworkClientProtocol {
    
    private(
        set
    ) var fetchCalled = false
    private(
        set
    ) var fetchWithCombineCalled = false
    
    func fetch(
        session: URLSession
    ) -> RandomLocation {
        fetchCalled = true
        return StaticLoader.loadJSONFromFileReturnDecodedData(
            file: "MockNetworkResponse"
        )
    }
    
    func fetchWithCombine() throws -> AnyPublisher<
        MapApp.RandomLocationModel,
        Error
    > {
        fetchWithCombineCalled = true
        return Just(
            RandomLocationModel(
                location: RandomLocation(
                    lat: "52.0",
                    long: "4.0",
                    name: "Bristol"
                )
            )
        ).setFailureType(
            to: Error.self
        ).eraseToAnyPublisher()
    }
    
}

class MockNetworkClientThrowInvalidURL: NetworkClientProtocol {
    
    private(
        set
    ) var fetchCalled = false
    private(
        set
    ) var fetchWithCombineCalled = false
    
    func fetch(
        session: URLSession
    ) throws -> RandomLocation {
        fetchCalled = true
        throw NetworkError.invalidURL
    }
    
    func fetchWithCombine() throws -> AnyPublisher<
        MapApp.RandomLocationModel,
        Error
    > {
        fetchWithCombineCalled = true
        throw NetworkError.invalidURL
    }
    
}

class MockNetworkClientThrowInvalidResponse: NetworkClientProtocol {
    
    private(
        set
    ) var fetchCalled = false
    private(
        set
    ) var fetchWithCombineCalled = false
    
    func fetch(
        session: URLSession
    ) throws -> RandomLocation {
        fetchCalled = true
        throw NetworkError.invalidResponse
    }
    
    func fetchWithCombine() throws -> AnyPublisher<
        MapApp.RandomLocationModel,
        Error
    > {
        fetchWithCombineCalled = true
        return Fail(
            error: NetworkError.invalidResponse
        ).eraseToAnyPublisher()
    }
    
}

class MockNetworkClientThrowInvalidData: NetworkClientProtocol {
    
    private(
        set
    ) var fetchCalled = false
    private(
        set
    ) var fetchWithCombineCalled = false
    
    func fetch(
        session: URLSession
    ) throws -> RandomLocation {
        fetchCalled = true
        throw NetworkError.invalidData
    }
    
    func fetchWithCombine() throws -> AnyPublisher<
        MapApp.RandomLocationModel,
        Error
    > {
        fetchWithCombineCalled = true
        return Fail(
            error: NetworkError.invalidData
        ).eraseToAnyPublisher()
    }
    
}

class MockNetworkClientThrowNonNetworkError: NetworkClientProtocol {
    
    private(
        set
    ) var fetchCalled = false
    private(
        set
    ) var fetchWithCombineCalled = false
    
    func fetch(
        session: URLSession
    ) throws -> RandomLocation {
        fetchCalled = true
        throw UserLocationError.deniedPermissions
    }
    
    func fetchWithCombine() throws -> AnyPublisher<
        MapApp.RandomLocationModel,
        Error
    > {
        fetchWithCombineCalled = true
        return Fail(
            error: UserLocationError.deniedPermissions
        ).eraseToAnyPublisher()
    }
    
}
