//
//  ContentView.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    
    @StateObject private var vm: MapViewModel
    
    init(locationHelper: LocationHelper) {
        _vm = StateObject(
            wrappedValue: MapViewModel(locationHelper: locationHelper)
        )
    }
    
    var body: some View {
        Map(
            coordinateRegion: $vm.region,
            showsUserLocation: true
        )
        .ignoresSafeArea()
        .accentColor(.pink)
        .onAppear {
            vm.checkLocationServices()
            vm.checkLocationPermissions()
        }
    }
}
