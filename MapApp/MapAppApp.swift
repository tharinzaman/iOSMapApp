//
//  MapAppApp.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import SwiftUI
import MapKit

@main
struct MapAppApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeScreen(
                locationHelper: UserLocationHelperImpl(
                    locationManager: CLLocationManager.locationServicesEnabled() ? CLLocationManager() : nil
                ),
                client: NetworkClientImpl()
            )
        }
    }
}
