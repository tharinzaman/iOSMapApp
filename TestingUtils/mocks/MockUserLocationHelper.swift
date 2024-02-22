//
//  MockLocationHelper.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 22/02/2024.
//

import Foundation
import MapKit
@testable import MapApp

class MockUserLocationHelperSuccess: UserLocationHelper {
    
    private(set) var checkIfLocationServicesAreEnabledCalled = false
    private(set) var checkIfLocationPermissionsAreGrantedCalled = false
    private(set) var getUserLocationCalled = false

    func checkIfLocationServicesAreEnabled() throws {
        checkIfLocationServicesAreEnabledCalled = true
    }
    
    func checkIfLocationPermissionsAreGranted() throws -> Bool {
        checkIfLocationPermissionsAreGrantedCalled = true
        return true
    }
    
    func getUserLocation() -> MKCoordinateRegion? {
        getUserLocationCalled = true
        return MKCoordinateRegion(
            center: MapConstants.DEFAULT_LOCATION,
            span: MapConstants.SPAN
        )
    }
}

class MockUserLocationHelperFailure: UserLocationHelper {
    
    private(set) var checkIfLocationServicesAreEnabledCalled = false
    private(set) var checkIfLocationPermissionsAreGrantedCalled = false
    private(set) var getUserLocationCalled = false
    
    func checkIfLocationServicesAreEnabled() throws {
        checkIfLocationServicesAreEnabledCalled = true
        throw UserLocationError.locationServicesDisabled
    }
    
    func checkIfLocationPermissionsAreGranted() throws -> Bool {
        checkIfLocationPermissionsAreGrantedCalled = true
        return false
    }
    
    func getUserLocation() -> MKCoordinateRegion? {
        getUserLocationCalled = true
        return nil
    }
    
}

class MockUserLocationHelperPermissionCheckThrowsUserLocationError: UserLocationHelper {
    
    private(set) var checkIfLocationServicesAreEnabledCalled = false
    private(set) var checkIfLocationPermissionsAreGrantedCalled = false
    private(set) var getUserLocationCalled = false
    
    func checkIfLocationServicesAreEnabled() throws {
        checkIfLocationServicesAreEnabledCalled = true
    }
    
    func checkIfLocationPermissionsAreGranted() throws -> Bool {
        checkIfLocationPermissionsAreGrantedCalled = true
        throw UserLocationError.deniedPermissions
    }
    
    func getUserLocation() -> MKCoordinateRegion? {
        getUserLocationCalled = true
        return MKCoordinateRegion(
            center: MapConstants.DEFAULT_LOCATION,
            span: MapConstants.SPAN
        )
    }

}

class MockUserLocationHelperPermissionCheckThrowsNonUserLocationError: UserLocationHelper {
    
    private(set) var checkIfLocationServicesAreEnabledCalled = false
    private(set) var checkIfLocationPermissionsAreGrantedCalled = false
    private(set) var getUserLocationCalled = false
    
    func checkIfLocationServicesAreEnabled() throws {
        checkIfLocationServicesAreEnabledCalled = true
    }
    
    func checkIfLocationPermissionsAreGranted() throws -> Bool {
        checkIfLocationPermissionsAreGrantedCalled = true
        throw NetworkError.invalidData
    }
    
    func getUserLocation() -> MKCoordinateRegion? {
        getUserLocationCalled = true
        return MKCoordinateRegion(
            center: MapConstants.DEFAULT_LOCATION,
            span: MapConstants.SPAN
        )
    }
    
}
