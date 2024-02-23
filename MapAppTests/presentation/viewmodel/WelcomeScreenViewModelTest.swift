//
//  WelcomeScreenViewModelTest.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import XCTest
@testable import MapApp

final class WelcomeScreenViewModelTest: XCTestCase {
    
    private var alertHelper: AlertHelper!
    
    override func setUp() {
        alertHelper = MockAlertHelperSuccess()
    }
    
    override func tearDown() {
        alertHelper = nil
    }
    
    func test_checkLocationServices_success() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperSuccess()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: self.alertHelper
        )
        // ACT
        vm.checkLocationServices()
        // ASSERT
        XCTAssertNil(
            vm.alert
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationServicesAreEnabledCalled
        )
    }
    
    func test_checkLocationServices_failure_servicesDisabled() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperFailure()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: self.alertHelper
        )
        // ACT
        vm.checkLocationServices()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.locationServicesDisabled.message
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationServicesAreEnabledCalled
        )
    }
    
    func test_checkLocationPermissions_success() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperSuccess()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: self.alertHelper
        )
        // ACT
        vm.checkLocationPermissions()
        // ASSERT
        XCTAssertNil(
            vm.alert
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationPermissionsAreGrantedCalled
        )
    }
    
    func test_checkLocationPermissions_failure_returnsFalse() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperFailure()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: self.alertHelper
        )
        // ACT
        vm.checkLocationPermissions()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.deniedPermissions.message
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationPermissionsAreGrantedCalled
        )
    }
    
    func test_checkLocationPermissions_failure_userLocationErrorThrown() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperPermissionCheckThrowsUserLocationError()
        let alertHelper = MockAlertHelperSuccess()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: alertHelper
        )
        // ACT
        vm.checkLocationPermissions()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.deniedPermissions.message
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationPermissionsAreGrantedCalled
        )
        XCTAssertTrue(
            alertHelper.errorToUserLocationErrorAlertCalled
        )
        
    }
    
    func test_checkLocationPermissions_failure_otherErrorThrown() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperPermissionCheckThrowsNonUserLocationError()
        let alertHelper = MockAlertHelperSuccess()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: alertHelper
        )
        // ACT
        vm.checkLocationPermissions()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.unableToComplete.message
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationPermissionsAreGrantedCalled
        )
        XCTAssertTrue(
            alertHelper.errorToUserLocationErrorAlertCalled
        )
    }
    
    func test_checkLocationPermissions_failure_alertHelperFails() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperPermissionCheckThrowsUserLocationError()
        let alertHelper = MockAlertHelperFailure()
        let vm = WelcomeScreenViewModel(
            locationHelper: locationHelper,
            alertHelper: alertHelper
        )
        // ACT
        vm.checkLocationPermissions()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.unableToComplete.message
        )
        XCTAssertTrue(
            locationHelper.checkIfLocationPermissionsAreGrantedCalled
        )
        XCTAssert(
            alertHelper.errorToUserLocationErrorAlertCalled
        )
    }
}
