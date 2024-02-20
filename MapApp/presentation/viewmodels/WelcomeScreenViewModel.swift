//
//  MapViewModel.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import MapKit

final class WelcomeScreenViewModel: ObservableObject {
    
    private let locationHelper: UserLocationHelperProtocol
    
    init(
        locationHelper: UserLocationHelperProtocol
    ) {
        self.locationHelper = locationHelper
    }
    
    func checkLocationServices() {
        locationHelper.checkIfLocationServicesAreEnabled()
    }
    
    func checkLocationPermissions() {
        locationHelper.checkIfLocationPermissionsAreGranted()
    }
    
}


