//
//  LocationHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

protocol UserLocationHelperProtocol {
    func checkIfLocationServicesAreEnabled() throws
    func checkIfLocationPermissionsAreGranted() throws -> Bool
    func getUserLocation() -> MKCoordinateRegion?
}
