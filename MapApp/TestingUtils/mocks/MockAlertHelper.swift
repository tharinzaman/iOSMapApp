//
//  MockAlertHelper.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 22/02/2024.
//

import Foundation
@testable import MapApp

class MockAlertHelperSuccess: AlertHelper {
    
    private(set) var errorToUserLocationErrorAlertCalled = false
    private(set) var errorToNetworkErrorAlertCalled = false

    func errorToUserLocationErrorAlert(error: Error) -> AlertModel {
        errorToUserLocationErrorAlertCalled = true
        if error is UserLocationError {
            if error as! UserLocationError == UserLocationError.locationServicesDisabled {
                return AlertItem.locationServicesDisabled
            } else {
                return AlertItem.deniedPermissions
            }
        } else {
            return AlertItem.unableToComplete
        }
    }
    
    func errorToNetworkErrorAlert(error: Error) -> AlertModel {
        errorToNetworkErrorAlertCalled = true
        if error is NetworkError {
            return AlertItem.invalidURL
        } else {
            return AlertItem.unableToComplete
        }
    }
    
}

class MockAlertHelperFailure: AlertHelper {
    
    private(set) var errorToUserLocationErrorAlertCalled = false
    private(set) var errorToNetworkErrorAlertCalled = false

    func errorToUserLocationErrorAlert(error: Error) -> AlertModel {
        errorToUserLocationErrorAlertCalled = true
        return AlertItem.unableToComplete
    }
    
    func errorToNetworkErrorAlert(error: Error) -> AlertModel {
        errorToNetworkErrorAlertCalled = true
        return AlertItem.unableToComplete
    }
    
}

