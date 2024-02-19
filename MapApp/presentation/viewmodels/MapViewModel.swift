//
//  MapViewModel.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import MapKit

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationHelper: LocationHelper
    
    init(locationHelper: LocationHelper) {
        self.locationHelper = locationHelper
    }
    
    @Published var region = MKCoordinateRegion(
        center: Constants.defaultLocation,
        span: Constants.span
    )
    
    func checkLocationServices() {
        locationHelper.checkIfLocationServicesAreEnabled()
    }
    
    func checkLocationPermissions() {
        if locationHelper.checkIfLocationPermissionsAreGranted() {
            if let userLocation = locationHelper.getUserLocation() {
                self.region = userLocation
            }
        
        }
    }
    
}

// MARK: Extension for delegate methods
extension MapViewModel {
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        checkLocationPermissions()
    }
    
}


