//
//  MapScreenViewModelTest.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import XCTest
@testable import MapApp

final class MapScreenViewModelTest: XCTestCase {
    
    private var alertHelper: AlertHelper!
    private var locationHelper: UserLocationHelper!
    private var client: NetworkClientProtocol!
    
    override func setUp() {
        alertHelper = MockAlertHelperSuccess()
        locationHelper = MockUserLocationHelperSuccess()
        client = MockNetworkClientSuccess()
    }
    
    override func tearDown() {
        alertHelper = nil
        locationHelper = nil
        client = nil
    }
    
    func test_getUserLocation_success() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperSuccess()
        let vm = MapScreenViewModel(
            locationHelper: locationHelper,
            client: self.client,
            alertHelper: self.alertHelper,
            destination: .UserLocation
        )
        // ACT
        vm.getUserLocation()
        // ASSERT
        XCTAssertNotEqual(
            vm.position.region?.center.latitude,
            MapConstants.LAT
        )
        XCTAssertNil(
            vm.alert
        )
        XCTAssertTrue(
            locationHelper.getUserLocationCalled
        )
    }
    
    func test_getUserLocation_failure_unableToLocateUser() {
        // ASSIGN
        let locationHelper = MockUserLocationHelperFailure()
        let vm = MapScreenViewModel(
            locationHelper: locationHelper,
            client: self.client,
            alertHelper: self.alertHelper,
            destination: .UserLocation
        )
        // ACT
        vm.getUserLocation()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.unableToComplete.message
        )
        XCTAssertEqual(
            vm.position.region?.center.latitude,
            MapConstants.LAT
        )
        XCTAssertTrue(
            locationHelper.getUserLocationCalled
        )
    }
    
    func test_getRandomLocation_success() async {
        // ASSIGN
        let client = MockNetworkClientSuccess()
        let alertHelper = MockAlertHelperSuccess()
        let vm = MapScreenViewModel(
            locationHelper: self.locationHelper,
            client: client,
            alertHelper: alertHelper,
            destination: .RandomLocation
        )
        // ACT
        await vm.getRandomLocation()
        // ASSERT
        XCTAssertNotEqual(
            vm.position.region?.center.latitude,
            MapConstants.LAT
        )
        XCTAssertNotEqual(
            vm.randomLocation.lat,
            String(
                MapConstants.LAT
            )
        )
        XCTAssertNil(
            vm.alert
        )
        XCTAssertTrue(
            client.fetchCalled
        )
        XCTAssertFalse(
            alertHelper.errorToNetworkErrorAlertCalled
        )
    }
    
    func test_getRandomLocation_failure_networkErrorThrown() async {
        // ASSIGN
        let client = MockNetworkClientThrowInvalidURL()
        let alertHelper = MockAlertHelperSuccess()
        let vm = MapScreenViewModel(
            locationHelper: self.locationHelper,
            client: client,
            alertHelper: alertHelper,
            destination: .RandomLocation
        )
        // ACT
        await vm.getRandomLocation()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.invalidURL.message
        )
        XCTAssertEqual(
            vm.position.region?.center.latitude,
            MapConstants.LAT
        )
        XCTAssertEqual(
            vm.randomLocation.lat,
            String(
                MapConstants.LAT
            )
        )
        XCTAssertTrue(
            client.fetchCalled
        )
        XCTAssertTrue(
            alertHelper.errorToNetworkErrorAlertCalled
        )
    }
    
    func test_getRandomLocation_failure_nonNetworkErrorThrown() async {
        // ASSIGN
        let alertHelper = MockAlertHelperSuccess()
        let client = MockNetworkClientThrowNonNetworkError()
        let vm = MapScreenViewModel(
            locationHelper: self.locationHelper,
            client: client,
            alertHelper: alertHelper,
            destination: .RandomLocation
        )
        // ACT
        await vm.getRandomLocation()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.unableToComplete.message
        )
        XCTAssertEqual(
            vm.position.region?.center.latitude,
            MapConstants.LAT
        )
        XCTAssertEqual(
            vm.randomLocation.lat,
            String(
                MapConstants.LAT
            )
        )
        XCTAssertTrue(
            client.fetchCalled
        )
        XCTAssertTrue(
            alertHelper.errorToNetworkErrorAlertCalled
        )
    }
    
    func test_getRandomLocation_failure_alertHelperFails() async {
        // ASSIGN
        let alertHelper = MockAlertHelperFailure()
        let client = MockNetworkClientThrowInvalidURL()
        let vm = MapScreenViewModel(
            locationHelper: self.locationHelper,
            client: client,
            alertHelper: alertHelper,
            destination: .RandomLocation
        )
        // ACT
        await vm.getRandomLocation()
        // ASSERT
        XCTAssertEqual(
            vm.alert?.message,
            AlertItem.unableToComplete.message
        )
        XCTAssertEqual(
            vm.position.region?.center.latitude,
            MapConstants.LAT
        )
        XCTAssertEqual(
            vm.randomLocation.lat,
            String(
                MapConstants.LAT
            )
        )
        XCTAssertTrue(
            client.fetchCalled
        )
        XCTAssertTrue(
            alertHelper.errorToNetworkErrorAlertCalled
        )
    }
    
}
