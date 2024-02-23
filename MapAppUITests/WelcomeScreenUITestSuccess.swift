//
//  WelcomeScreenUITest.swift
//  MapAppUITests
//
//  Created by Tharin Zaman on 23/02/2024.
//

import XCTest
@testable import MapApp

final class WelcomeScreenSuccessUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-services-enabled":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_allElementsPresented() {
        // ASSIGN
        let welcomeText = app.staticTexts["welcome-text"]
        let globeImage = app.images["globe-image"]
        let whereToText = app.staticTexts["where-to-text"]
        let userLocationButton = app.buttons["user-location-button"]
        let randomLocationButton = app.buttons["random-location-button"]
        // ACT
        // ASSERT
        XCTAssertTrue(welcomeText.exists)
        XCTAssertTrue(globeImage.exists)
        XCTAssertTrue(whereToText.exists)
        XCTAssertTrue(userLocationButton.exists)
        XCTAssertTrue(randomLocationButton.exists)
    }
    
    
}

final class WelcomeScreenFailureUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var alert: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-services-enabled":"0"]
        app.launch()
        
        alert = app.alerts["Location services disabled"]
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
    }
    
}

