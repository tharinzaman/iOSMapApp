//
//  MapScreenUITest.swift
//  MapAppUITests
//
//  Created by Tharin Zaman on 23/02/2024.
//

import XCTest
@testable import MapApp

final class MapScreenSuccessUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var locationMap: XCUIElement!
    private var randomLocationNameMarker: XCUIElement!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-services-enabled":"1"]
        app.launchEnvironment = ["-networking-success":"1"]
        app.launch()
        
        locationMap = app.otherElements["location-map"]
        randomLocationNameMarker = app.otherElements["Peterchurch"]
    }
    
    override func tearDown() {
        app = nil
        locationMap = nil
    }
    
    func test_navigateToUserLocation_success() {
        // ASSIGN
        let userLocationButton = app.buttons["user-location-button"]
        // ACT
        userLocationButton.tap()
        // ASSERT
        XCTAssertTrue(
            locationMap.exists
        )
        XCTAssertFalse(randomLocationNameMarker.exists)
    }
    
    func test_navigateToRandomLocation_success() {
        // ASSIGN
        let randomLocationButton = app.buttons["random-location-button"]
        // ACT
        randomLocationButton.tap()
        // ASSERT
        XCTAssertTrue(
            locationMap.exists
        )
        XCTAssertTrue(randomLocationNameMarker.exists)
    }
}

final class MapScreenFailureUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var firstAlertButton: XCUIElement!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-services-enabled":"0"]
        app.launchEnvironment = ["-networking-success":"0"]
        app.launch()
        
        firstAlertButton = app.alerts.firstMatch.buttons.firstMatch
        
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_navigateToUserLocation_servicesDisabled() {
        // ASSIGN
        let userLocationButton = app.buttons["user-location-button"]
        let servicesDisabledAlert = app.alerts["Unable to complete."]
        // ACT
        firstAlertButton.tap()
        userLocationButton.tap()
        // ASSERT
        XCTAssertTrue(servicesDisabledAlert.exists)
    }
    
    func test_navigateToRandomLocation_invalidURL() {
        // ASSIGN
        let randomLocationButton = app.buttons["random-location-button"]
        let invalidURLAlert = app.alerts["Invalid server URL."]
        // ACT
        firstAlertButton.tap()
        randomLocationButton.tap()
        // ASSERT
        XCTAssertTrue(invalidURLAlert.exists)
    }
    
}
