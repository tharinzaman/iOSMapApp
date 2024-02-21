//
//  AlertHelperImplTest.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import XCTest
@testable import MapApp

final class AlertHelperImplTest: XCTestCase {

    private var helper = AlertHelperImpl()
    
    func test_errorToUserLocationAlert_success() {
        // ASSIGN
        
        // ACT
        let result = helper.errorToUserLocationErrorAlert(
            error: UserLocationError.deniedPermissions
        )
        // ASSERT
        XCTAssertEqual(
            result.message,
            AlertItem.deniedPermissions.message
        )
    }
    
    func test_errorToUserLocationAlert_failure() {
        // ASSIGN
        
        // ACT
        let result = helper.errorToUserLocationErrorAlert(
            error: NetworkError.invalidData
        )
        // ASSERT
        XCTAssertEqual(
            result.message,
            AlertItem.unableToComplete.message
        )
    }
    
    func test_errorToNetworkErrorAlert_success() {
        // ASSIGN
        
        // ACT
        let result = helper.errorToNetworkErrorAlert(
            error: NetworkError.invalidURL
        )
        // ASSERT
        XCTAssertEqual(
            result.message,
            AlertItem.invalidURL.message
        )
    }
    
    func test_errorToNetworkErrorAlert_failure() {
        // ASSIGN
        
        // ACT
        let result = helper.errorToNetworkErrorAlert(
            error: UserLocationError.deniedPermissions
        )
        // ASSERT
        XCTAssertEqual(
            result.message,
            AlertItem.unableToComplete.message
        )
    }
}
