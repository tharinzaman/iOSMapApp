//
//  MockAlertHelper.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 22/02/2024.
//

import Foundation
@testable import MapApp

class MockAlertHelperSuccess: AlertHelper {
    
    private(set) var errorToUserLocationErrorAlert = false
    private(set) var errorToNetworkErrorAlert = false

    func errorToUserLocationErrorAlert(error: Error) -> AlertModel {
        errorToUserLocationErrorAlert = true
        return AlertItem.deniedPermissions
    }
    
    func errorToNetworkErrorAlert(error: Error) -> AlertModel {
        errorToNetworkErrorAlert = true
        return AlertItem.invalidURL
    }
    
}

class MockAlertHelperFailure: AlertHelper {
    
    private(set) var errorToUserLocationErrorAlert = false
    private(set) var errorToNetworkErrorAlert = false

    func errorToUserLocationErrorAlert(error: Error) -> AlertModel {
        errorToUserLocationErrorAlert = true
        return AlertItem.invalidURL
    }
    
    func errorToNetworkErrorAlert(error: Error) -> AlertModel {
        errorToNetworkErrorAlert = true
        return AlertItem.deniedPermissions
    }
    
}

