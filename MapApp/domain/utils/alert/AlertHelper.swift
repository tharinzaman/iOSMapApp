//
//  AlertHelperImpl.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation

struct AlertHelper {
    
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
