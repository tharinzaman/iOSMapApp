//
//  LocationHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

protocol LocationHelper {
    func checkIfLocationServicesAreEnabled()
    func checkIfLocationPermissionsAreGranted() -> Bool
    func getUserLocation() -> MKCoordinateRegion?
}