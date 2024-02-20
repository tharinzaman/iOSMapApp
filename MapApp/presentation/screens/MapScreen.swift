//
//  ContentView.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    
    @StateObject private var vm: MapScreenViewModel
    @State private var destination: Destination
    
    init(
        locationHelper: UserLocationHelperProtocol,
        client: NetworkClientProtocol,
        destination: Destination
    ) {
        _vm = StateObject(
            wrappedValue: MapScreenViewModel(
                locationHelper: locationHelper,
                client: client,
                destination: destination
            )
        )
        self.destination = destination
    }
    
    var body: some View {
        
        Map(
            position: $vm.position
        ) {
            if destination == .UserLocation {
                UserAnnotation()
            } else {
                Marker(
                    vm.randomLocation.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: Double(vm.randomLocation.lat) ?? MapConstants.lat,
                        longitude: Double(vm.randomLocation.long) ?? MapConstants.long
                    )
                )
            }
        }
        .mapStyle(
            .hybrid(
                elevation: .realistic
            )
        )
        .ignoresSafeArea()
        .onAppear {
            if destination == .UserLocation {
                vm.getUserLocation()
            }
        }
        // MARK: Comment/Uncomment the following code if you want/don't want to use combine
//        .task {
//            if destination == .RandomLocation {
//                await vm.getRandomLocation()
//            }
//        }
        
    }
}
