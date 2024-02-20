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
    
    private let locationHelper: UserLocationHelperProtocol
    private let client: NetworkClientProtocol
    
    @StateObject var vm: WelcomeScreenViewModel
    
    init(
        locationHelper: UserLocationHelperProtocol,
        client: NetworkClientProtocol
    ) {
        self.locationHelper = locationHelper
        self.client = client
        _vm = StateObject(
            wrappedValue: WelcomeScreenViewModel(
                locationHelper: locationHelper
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
                            locationHelper: locationHelper
                        )
                        NavigateButton(
                            destination: .RandomLocation,
                            client: client,
                            locationHelper: locationHelper
                        )
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                vm.checkLocationServices()
                vm.checkLocationPermissions()
            }
        }
    }
}

struct WelcomeText: View {
    var body: some View {
        Text(
            Strings.Welcome
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
            Strings.WhereTo
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
    let locationHelper: UserLocationHelperProtocol
    
    var destinationString: String {
        switch destination {
        case .UserLocation:
            Strings.MyLocation
        default:
            Strings.RandomLocation
        }
    }
    
    var body: some View {
        NavigationLink(
            destinationString,
            destination: MapScreen(
                locationHelper: locationHelper,
                client: client,
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

