//
//  LocationHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

class UserLocationHelperImpl: NSObject {
    
    var locationManager: CLLocationManager?
    
    init(
        locationManager: CLLocationManager? = nil
    ) {
        self.locationManager = locationManager
    }
    
    func getUserLocation() -> MKCoordinateRegion? {
        guard let locationManager else {
            return nil
        }
        
        do {
            guard try checkIfLocationPermissionsAreGranted() == true else {
                return nil
            }
        } catch {
            return nil
        }
        
        do {
            try checkIfLocationServicesAreEnabled()
        } catch {
            return nil
        }
        
        return MKCoordinateRegion(
            center: locationManager.location?.coordinate ?? MapConstants.DEFAULT_LOCATION,
            span: MapConstants.SPAN
        )
    }
}

// MARK: Extension for checking location services and permissions
extension UserLocationHelperImpl: UserLocationHelper {
    
    func checkIfLocationServicesAreEnabled() throws {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            throw UserLocationError.locationServicesDisabled
        }
    }
    
    func checkIfLocationPermissionsAreGranted() throws -> Bool {
        guard let locationManager else {
            return false
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            throw UserLocationError.restrictedPermissions
        case .denied:
            throw UserLocationError.deniedPermissions
        case .authorizedAlways:
            return true
        case .authorizedWhenInUse:
            return true
        @unknown default:
            throw UserLocationError.unresolvedPermissions
        }
        
        return false
    }
}
