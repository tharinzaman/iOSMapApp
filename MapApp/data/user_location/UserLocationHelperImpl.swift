//
//  LocationHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit
import AVFoundation

class UserLocationHelperImpl: NSObject, UserLocationHelper {
    
    var locationManager: LocationManager?
    
    init(
        locationManager: LocationManager? = nil
    ) {
        self.locationManager = locationManager
    }
    
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
    
    func getUserLocation() throws -> MKCoordinateRegion? {
        guard let locationManager else {
            return nil
        }
        
        do {
            guard try checkIfLocationPermissionsAreGranted() == true else {
                throw UserLocationError.deniedPermissions
            }
        } catch {
            throw error
        }
        
        do {
            try checkIfLocationServicesAreEnabled()
        } catch {
            throw UserLocationError.locationServicesDisabled
        }
        
        return MKCoordinateRegion(
            center: locationManager.location?.coordinate ?? MapConstants.DEFAULT_LOCATION,
            span: MapConstants.SPAN
        )
    }
}
