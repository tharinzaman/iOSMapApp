//
//  AlertItem.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation

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
