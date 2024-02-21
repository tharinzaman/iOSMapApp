//
//  Errors.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation

enum UserLocationError: Error {
    case restrictedPermissions
    case deniedPermissions
    case unresolvedPermissions
    case locationServicesDisabled
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
