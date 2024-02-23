//
//  UserLocationHelperImplTest.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import XCTest
import MapKit
@testable import MapApp

/**
 The methods in this class depend on location services being enabled on the device. This is because we currently cannot mock the static method CLLocationManager.locationServicesEnabled().  If the user's location services are disabled then many of the tests will fail. Unfortunately I have not yet found a way around this, finding a way around this static method would be significantly beneficial for this test class.
 */

final class UserLocationHelperImplTest: XCTestCase {
    
    
    private var helper: UserLocationHelper!
    
    override func setUp() {
        helper = UserLocationHelperImpl(
            locationManager: MockCLLocationManagerSuccess()
        )
    }
    
    override func tearDown() {
        helper = nil
    }
    
    func test_getUserLocation_success() throws {
        // ASSIGN
        // ACT
        let result = try helper.getUserLocation()
        // ASSERT
        XCTAssertEqual(
            result?.center.latitude,
            50.0
        )
    }
    
    func test_getUserLocation_locationManagerNil() throws {
        // ASSIGN
        helper = UserLocationHelperImpl()
        // ACT
        let result = try helper.getUserLocation()
        // ASSERT
        XCTAssertNil(
            result
        )
    }
    
    func test_getUserLocation_permissionsCheckThrowsErrorAsPermissionsAreDenied() {
        // ASSIGN
        helper = UserLocationHelperImpl(
            locationManager: MockCLLocationManagerFailure()
        )
        // ACT
        do {
            try helper.getUserLocation()
        } catch {
            guard let thrownError = error as? UserLocationError else {
                XCTFail(
                    "Wrong type of error"
                )
                return
            }
            // ASSERT
            XCTAssertEqual(
                thrownError,
                UserLocationError.deniedPermissions
            )
        }
        
    }
    
    func test_getUserLocation_servicesDisabled() {
        // Might not be possible to do this one as we need to mock a static method and that is not possible.
    }
    
    func test_checkIfLocationServicesAreEnabled_success() {
        // ASSIGN
        // ACT
        // ASSERT
        XCTAssertNoThrow(
            try helper.checkIfLocationServicesAreEnabled()
        )
    }
    
    func test_checkIfLocationServicesAreEnabled_errorThrown() {
        // Might not be possible to do this one as we need to mock a static method and that is not possible.
    }
    
    func test_checkIfLocationPermissionsAreGranted_success() throws {
        // ASSIGN
        // ACT
        let result = try helper.checkIfLocationPermissionsAreGranted()
        // ASSERT
        XCTAssertTrue(
            result
        )
    }
    
    func test_checkIfLocationPermissionsAreGranted_returnedFalse() throws {
        // ASSIGN
        helper = UserLocationHelperImpl()
        // ACT
        let result = try helper.checkIfLocationPermissionsAreGranted()
        // ASSERT
        XCTAssertFalse(
            result
        )
    }
    
    func test_checkIfLocationPermissionsAreGranted_errorThrown() {
        // ASSIGN
        helper = UserLocationHelperImpl(
            locationManager: MockCLLocationManagerFailure()
        )
        // ACT
        do {
            try helper.checkIfLocationPermissionsAreGranted()
        } catch {
            guard let thrownError = error as? UserLocationError else {
                XCTFail(
                    "Wrong type of error"
                )
                return
            }
            // ASSERT
            XCTAssertEqual(
                thrownError,
                UserLocationError.deniedPermissions
            )
        }
    }
}
