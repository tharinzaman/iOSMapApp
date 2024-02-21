//
//  Alert.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import SwiftUI

struct AlertModel: Identifiable{
    
    init(
        title: String,
        message: String
    ) {
        self.title = Text(
            title
        )
        self.message = Text(
            message
        )
    }
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton = Alert.Button.default(
        Text(
            Strings.OK
        )
    )
}

struct AlertItem {
    
    static let restrictedPermissions = AlertModel(
        title: AlertStrings.RESTRICTED_PERMISSIONS_TITLE,
        message: AlertStrings.RESTRICTED_PERMISSIONS_MESSAGE
    )
    
    static let deniedPermissions = AlertModel(
        title: AlertStrings.DENIED_PERMISSIONS_TITLE,
        message: AlertStrings.DENIED_PERMISSIONS_MESSAGE
    )
    
    static let unresolvedPermissions = AlertModel(
        title: AlertStrings.UNRESOLVED_PERMISSIONS_TITLE,
        message: AlertStrings.UNRESOLVED_PERMISSIONS_MESSAGE
    )
    
    static let locationServicesDisabled = AlertModel(
        title: AlertStrings.LOCATION_SERVICES_DISABLED_TITLE,
        message: AlertStrings.LOCATION_SERVICES_DISABLED_MESSAGE
    )
    
    static let invalidURL = AlertModel(
        title: AlertStrings.INVALID_URL_TITLE,
        message: AlertStrings.UNABLE_TO_FETCH_RANDOM_LOCATION
    )
    
    static let invalidResponse = AlertModel(
        title: AlertStrings.INVALID_RESPONSE_TITLE,
        message: AlertStrings.UNABLE_TO_FETCH_RANDOM_LOCATION
    )
    
    static let invalidData = AlertModel(
        title: AlertStrings.INVALID_DATA_TITLE,
        message: AlertStrings.UNABLE_TO_FETCH_RANDOM_LOCATION
    )
    
    static let unableToComplete = AlertModel(
        title: AlertStrings.UNABLE_TO_COMPLETE_TITLE,
        message: AlertStrings.UNABLE_TO_COMPLETE_MESSAGE
    )
    
}

struct AlertStrings {
    
    static let RESTRICTED_PERMISSIONS_TITLE = "Permissions restricted"
    static let RESTRICTED_PERMISSIONS_MESSAGE = "Location permissions are currently restricted. Please ask administrator to enable."
    
    static let DENIED_PERMISSIONS_TITLE = "Permissions denied"
    static let DENIED_PERMISSIONS_MESSAGE = "Location permissions have been denied. Please enable in settings."
    
    static let UNRESOLVED_PERMISSIONS_TITLE = "Permissions unresolved"
    static let UNRESOLVED_PERMISSIONS_MESSAGE = "Permissions could not be resolved. Please try again later."
    
    static let LOCATION_SERVICES_DISABLED_TITLE = "Location services disabled"
    static let LOCATION_SERVICES_DISABLED_MESSAGE = "Location services are disabled. Please enable in settings."
    
    static let INVALID_URL_TITLE = "Invalid server URL."
    static let INVALID_RESPONSE_TITLE = "Invalid server response."
    static let INVALID_DATA_TITLE = "Server returned "
    static let UNABLE_TO_FETCH_RANDOM_LOCATION = "Unable to fetch random location"
    
    static let UNABLE_TO_COMPLETE_TITLE = "Unable to complete."
    static let UNABLE_TO_COMPLETE_MESSAGE = "Please try again later"
    
    static func errorToUserLocationAlert(
        error: Error
    ) -> AlertModel {
        if let permissionError = error as? UserLocationError {
            return switch permissionError {
            case .deniedPermissions: AlertItem.deniedPermissions
            case .restrictedPermissions: AlertItem.restrictedPermissions
            case .unresolvedPermissions: AlertItem.unresolvedPermissions
            case .locationServicesDisabled: AlertItem.locationServicesDisabled
            }
        } else {
            return AlertItem.unableToComplete
        }
    }
    
    static func errorToNetworkError(
        error: Error
    ) -> AlertModel {
        if let networkError = error as? NetworkError {
            return switch networkError {
            case .invalidData: AlertItem.invalidData
            case .invalidURL: AlertItem.invalidURL
            case .invalidResponse: AlertItem.invalidResponse
            }
        } else {
            return AlertItem.unableToComplete
        }
    }
    
}
