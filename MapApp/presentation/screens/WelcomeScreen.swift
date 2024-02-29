//
//  WelcomeView.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import SwiftUI
import MapKit

/**
 All UI Components have been put into one file as we don't reuse them anywhere else in the application.
 */

struct WelcomeScreen: View {
    
    private let locationHelper: UserLocationHelper
    private let client: NetworkClientProtocol
    private let alertHelper: AlertHelper
    
    @StateObject var vm: WelcomeScreenViewModel
    
    init(
        locationHelper: UserLocationHelper,
        alertHelper: AlertHelper,
        client: NetworkClientProtocol
    ) {
        self.locationHelper = locationHelper
        self.alertHelper = alertHelper
        self.client = client
        /**
         If we are in debug mode and we are performing a UI test, then the locationHelper will be a mock. If the servicesEnabled argument for the UI test is true, we pass a successful mock. If it is false, we pass a failing mock.
         If we are in debug mode but we are NOT performing a UI test, then the locationHelper will be whatever was passed in the initializer.
         If we are not in debug mode, then the locationHelper will also be whatever was passed in the initializer.
         */
#if DEBUG
        let mockLocationHelper: UserLocationHelper = UITestingHelper.servicesEnabled ? MockUserLocationHelperSuccess() : MockUserLocationHelperFailure()
        _vm = StateObject(
            wrappedValue: WelcomeScreenViewModel(
                locationHelper: UITestingHelper.isUITest ? mockLocationHelper : locationHelper,
                alertHelper: alertHelper
            )
        )
#else
        _vm = StateObject(
            wrappedValue: WelcomeScreenViewModel(
                locationHelper: locationHelper,
                alertHelper: alertHelper
            )
        )
#endif
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(
                    .white
                )
                VStack(
                    alignment: .center,
                    spacing: 150
                ) {
                    WelcomeText().accessibilityIdentifier(
                        "welcome-text"
                    )
                    Image(
                        "Globe"
                    )
                    .frame(
                        height: 100
                    )
                    .accessibilityIdentifier(
                        "globe-image"
                    )
                    WhereToText()
                        .accessibilityIdentifier(
                            "where-to-text"
                        )
                    VStack(
                        spacing: 40
                    ) {
                        NavigateButton(
                            destination: .UserLocation,
                            client: client,
                            locationHelper: locationHelper,
                            alertHelper: alertHelper
                        ).accessibilityIdentifier(
                            "user-location-button"
                        )
                        NavigateButton(
                            destination: .RandomLocation,
                            client: client,
                            locationHelper: locationHelper,
                            alertHelper: alertHelper
                        ).accessibilityIdentifier(
                            "random-location-button"
                        )
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                vm.checkLocationPermissions()
                vm.checkLocationServices()
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
        }
    }
}

struct WelcomeText: View {
    var body: some View {
        Text(
            Strings.WELCOME
        )
        .font(
            .title
        )
        .fontWeight(
            .bold
        )
        .foregroundStyle(
            .blue
        )
    }
}

struct WhereToText: View {
    var body: some View {
        Text(
            Strings.WHERE_TO
        )
        .font(
            .title3
        )
        .fontWeight(
            .semibold
        )
        .foregroundStyle(
            .blue
        )
    }
}

struct NavigateButton: View {
    
    let destination: Destination
    let client: NetworkClientProtocol
    let locationHelper: UserLocationHelper
    let alertHelper: AlertHelper
    
    var destinationString: String {
        switch destination {
        case .UserLocation:
            Strings.MY_LOCATION
        default:
            Strings.RANDOM_LOCATION
        }
    }
    
    var body: some View {
        NavigationLink(
            destinationString,
            destination: MapScreen(
                locationHelper: locationHelper,
                client: client,
                alertHelper: alertHelper,
                destination: destination
            )
        ).buttonStyle(
            .borderedProminent
        )
        .controlSize(
            .large
        )
    }
}

