//
//  MapViewModel.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import MapKit

final class WelcomeScreenViewModel: ObservableObject {
    
    private let locationHelper: UserLocationHelper
    private let alertHelper: AlertHelper
    
    @Published var alert: AlertModel? = nil
    
    init(
        locationHelper: UserLocationHelper,
        alertHelper: AlertHelper
    ) {
        self.locationHelper = locationHelper
        self.alertHelper = alertHelper
    }
    
    func checkLocationServices() {
        do {
            try locationHelper.checkIfLocationServicesAreEnabled()
        } catch {
            self.alert = alertHelper.errorToUserLocationErrorAlert(error: error)
        }
    }
    
    func checkLocationPermissions() {
        do {
            let permissionStatus = try locationHelper.checkIfLocationPermissionsAreGranted()
            if permissionStatus == false {
                self.alert = AlertItem.deniedPermissions
            }
        } catch {
            self.alert = alertHelper.errorToUserLocationErrorAlert(error: error)
        }
    }
    
}


