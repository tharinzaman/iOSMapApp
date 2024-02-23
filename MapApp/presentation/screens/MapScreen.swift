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
        locationHelper: UserLocationHelper,
        client: NetworkClientProtocol,
        alertHelper: AlertHelper,
        destination: Destination
    ) {
        self.destination = destination
        /**
         If we are in debug mode and performing a UI test, then we will pass a mocked locationHelper and mocked client. Depending on if the servicesEnabled and networkingSuccess arguments for the UI test are true or false,  we pass successful or failing mocks for locationHelper and client.
         If we are in debug mode but NOT performing a UI test, then the locationHelper and client will be whatever was passed in the initializer.
         If we are not in debug mode, then the locationHelper and client will also be whatever was passed in the initializer.
         */
#if DEBUG
        let mockLocationHelper: UserLocationHelper = UITestingHelper.servicesEnabled ? MockUserLocationHelperSuccess() : MockUserLocationHelperFailure()
        let mockClient: NetworkClientProtocol = UITestingHelper.networkingSuccess ? MockNetworkClientSuccess() : MockNetworkClientThrowInvalidURL()
        _vm = StateObject(
            wrappedValue: UITestingHelper.isUITest ? MapScreenViewModel(
                locationHelper: mockLocationHelper,
                client: mockClient,
                alertHelper: alertHelper,
                destination: destination
            ) : MapScreenViewModel(
                locationHelper: locationHelper,
                client: client,
                alertHelper: alertHelper,
                destination: destination
            )
        )
#else
        _vm = StateObject(
            wrappedValue: MapScreenViewModel(
                locationHelper: locationHelper,
                client: client,
                alertHelper: alertHelper,
                destination: destination
            )
        )
#endif
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
                        latitude: Double(
                            vm.randomLocation.lat
                        ) ?? MapConstants.LAT,
                        longitude: Double(
                            vm.randomLocation.long
                        ) ?? MapConstants.LONG
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
        .task {
            if destination == .RandomLocation {
                await vm.getRandomLocation()
            }
        }
        .alert(
            item: $vm.alert
        ) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton
            )
        }
        .accessibilityIdentifier(
            "location-map"
        )
        
    }
}
