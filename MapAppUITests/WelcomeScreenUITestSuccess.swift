//
//  WelcomeScreenUITest.swift
//  MapAppUITests
//
//  Created by Tharin Zaman on 23/02/2024.
//

import XCTest
@testable import MapApp

final class WelcomeScreenUITestSuccess: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var userLocationButton: XCUIElement!
    private var randomLocationButton: XCUIElement!
    private var locationMap: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"1"]
        app.launchEnvironment = ["-permission-granted":"1"]
        app.launch()
        
        userLocationButton = app.buttons["user-location-button"]
        randomLocationButton = app.buttons["random-location-button"]
        locationMap = app.descendants(matching: .any)["location-map"]
    }
    
    override func tearDown() {
        app = nil
        userLocationButton = nil
        randomLocationButton = nil
        locationMap = nil
    }
    
    func test_allElementsPresented() {
        // ASSIGN
        let welcomeText = app.descendants(
            matching: .any
        )["welcome-text"]
        let globeImage = app.images["globe-image"]
        let whereToText = app.descendants(
            matching: .any
        )["where-to-text"]
        // ACT
        // ASSERT
        XCTAssertTrue(
            welcomeText.exists
        )
        XCTAssertTrue(
            globeImage.exists
        )
        XCTAssertTrue(
            whereToText.exists
        )
        XCTAssertTrue(
            userLocationButton.exists
        )
        XCTAssertTrue(
            randomLocationButton.exists
        )
    }
    
    func test_navigateToUserLocation_success() {
        // ASSIGN
        // ACT
        userLocationButton.tap()
        // ASSERT
        XCTAssertTrue(locationMap.exists)
    }
    
    func test_navigateToRandomLocation_success() {
        // ASSIGN
        // ACT
        randomLocationButton.tap()
        // ASSERT
        XCTAssertTrue(locationMap.exists)
    }
    
}

final class WelcomeScreenUITestFailure: XCTestCase {

    private var app: XCUIApplication!
    
    private var alert: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-permission-granted":"0"]
        app.launch()
        
        alert = app.alerts.firstMatch
    }
    
    override func tearDown() {
        app = nil
        alert = nil
    }
    
    func test_locationServicesDisabled_alertDisplayed() {
        // ASSIGN
        // ACT
        // ASSERT
        XCTAssertTrue(alert.exists)
        XCTAssertEqual(alert.title, AlertStrings.UNABLE_TO_COMPLETE_TITLE)
    }
    
}

