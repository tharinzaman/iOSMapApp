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
        _vm = StateObject(
            wrappedValue: WelcomeScreenViewModel(
                locationHelper: locationHelper,
                alertHelper: alertHelper
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(
                    .white
                )
                VStackLayout(
                    alignment: .center,
                    spacing: 150
                ) {
                    WelcomeText()
                    Image(
                        "Globe"
                    )
                    .frame(
                        height: 100
                    )
                    WhereToText()
                    VStack(
                        spacing: 40
                    ) {
                        NavigateButton(
                            destination: .UserLocation,
                            client: client,
                            locationHelper: locationHelper,
                            alertHelper: alertHelper
                        )
                        NavigateButton(
                            destination: .RandomLocation,
                            client: client,
                            locationHelper: locationHelper,
                            alertHelper: alertHelper
                        )
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                vm.checkLocationServices()
                vm.checkLocationPermissions()
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

