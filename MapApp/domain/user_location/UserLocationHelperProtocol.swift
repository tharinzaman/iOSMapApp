//
//  LocationHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

protocol UserLocationHelperProtocol {
    func checkIfLocationServicesAreEnabled()
    func checkIfLocationPermissionsAreGranted() -> Bool
    func getUserLocation() -> MKCoordinateRegion?
}
