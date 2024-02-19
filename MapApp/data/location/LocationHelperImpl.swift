//
//  LocationHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

class LocationHelperImpl: NSObject, CLLocationManagerDelegate {
    
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
        guard checkIfLocationPermissionsAreGranted() == true else {
            return nil
        }
        return MKCoordinateRegion(
            center: locationManager.location?.coordinate ?? Constants.defaultLocation,
            span: Constants.span
        )
    }
}

// MARK: Extension for checking location services and permissions
extension LocationHelperImpl: LocationHelper {
    
    func checkIfLocationServicesAreEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        } else {
            //TODO: Show an alert saying that location services are disabled and to allow in settings
        }
    }
    
    func checkIfLocationPermissionsAreGranted() -> Bool {
        guard let locationManager else {
            return false
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //TODO: Show alert saying that permissions are restricted
            return false
        case .denied:
            //TODO: Show alert saying that permissions have been denied and they can allow in settings
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        @unknown default:
            // TODO: Show alert saying that permissions are unresolved.
            return false
        }
        
        return false
    }
}
