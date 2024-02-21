//
//  MapViewModel.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import MapKit

final class WelcomeScreenViewModel: ObservableObject {
    
    private let locationHelper: UserLocationHelperProtocol
    private let alertHelper: AlertHelper
    
    @Published var alert: AlertModel? = nil
    
    init(
        locationHelper: UserLocationHelperProtocol,
        alertHelper: AlertHelper
    ) {
        self.locationHelper = locationHelper
        self.alertHelper = alertHelper
    }
    
    func checkLocationServices() {
        do {
            try locationHelper.checkIfLocationServicesAreEnabled()
        } catch {
            self.alert = AlertItem.locationServicesDisabled
        }
    }
    
    func checkLocationPermissions() {
        do {
            try locationHelper.checkIfLocationPermissionsAreGranted()
        } catch {
            self.alert = alertHelper.errorToUserLocationErrorAlert(error: error)
        }
    }
    
}


