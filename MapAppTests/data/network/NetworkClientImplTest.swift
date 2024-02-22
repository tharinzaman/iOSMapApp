//
//  NetworkClientImplTest.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import XCTest
@testable import MapApp

final class NetworkClientImplTest: XCTestCase {
    
    private var session: URLSession!
    private var jsonUrl: URL!
    
    private var client = NetworkClientImpl()

    override func setUp() {
        jsonUrl = URL(
            string: "https://api.3geonames.org/randomland.UK.json"
        )
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSession.self]
        session = URLSession(
            configuration: configuration
        )
    }
    
    override func tearDown() {
        session = nil
        jsonUrl = nil
    }
    
    func test_makeANetworkRequest_success() async throws {
        // ASSIGN
        let data = StaticLoader.loadJSONFromFileReturnData(
            file: "MockNetworkResponse"
        )
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.jsonUrl,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            return (
                response!,
                data
            )
        }
        let expectedResult = StaticLoader.loadJSONFromFileReturnDecodedData(
            file: "MockNetworkResponse"
        )
        // ACT
        let result: RandomLocation = try await client.fetch(
            session: self.session
        )
        // ASSERT
        XCTAssertEqual(
            result,
            expectedResult
        )
    }
    
    func test_makeANetworkRequest_failure_invalidUrl() async throws {
        let data = StaticLoader.loadJSONFromFileReturnData(
            file: "MockNetworkResponse"
        )
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse()
            return (
                response,
                data
            )
        }
        // ACT
        do {
            _ = try await client.fetch(
                session: self.session
            )
        } catch {
            guard let networkError = error as? NetworkError else {
                XCTFail(
                    "Wrong type of error"
                )
                return
            }
            // ASSERT
            XCTAssertEqual(
                networkError,
                NetworkError.invalidURL
            )
        }
    }
    
    func test_makeANetworkRequest_failure_invalidResponse() async throws {
        // ASSIGN
        let invalidStatusCode = 400
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.jsonUrl,
                statusCode: invalidStatusCode,
                httpVersion: nil,
                headerFields: nil
            )
            return (
                response!,
                nil
            )
        }
        // ACT
        do {
            _ = try await client.fetch(
                session: self.session
            )
        } catch {
            guard let networkError = error as? NetworkError else {
                XCTFail(
                    "Wrong type of error"
                )
                return
            }
            // ASSERT
            XCTAssertEqual(
                networkError,
                NetworkError.invalidResponse
            )
        }
    }
    
    func test_makeANetworkRequest_failure_invalidData() async throws {
        // ASSIGN
        MockURLSession.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.jsonUrl,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            return (
                response!,
                nil
            )
        }
        // ACT
        do {
            _ = try await client.fetch(
                session: self.session
            )
        } catch {
            guard let networkError = error as? NetworkError else {
                XCTFail(
                    "Wrong type of error"
                )
                return
            }
            // ASSERT
            XCTAssertEqual(
                networkError,
                NetworkError.invalidData
            )
        }
    }
    
}
