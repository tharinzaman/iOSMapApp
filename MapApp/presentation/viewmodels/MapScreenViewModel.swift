//
//  MapScreenViewModel.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import Combine

final class MapScreenViewModel: ObservableObject {
    
    private let locationHelper: UserLocationHelper
    private let client: NetworkClientProtocol
    private let alertHelper: AlertHelper
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        locationHelper: UserLocationHelper,
        client: NetworkClientProtocol,
        alertHelper: AlertHelper,
        destination: Destination
    ) {
        self.locationHelper = locationHelper
        self.client = client
        self.alertHelper = alertHelper
        // MARK: Uncomment/Comment the following lines if you want/don't want to use combine
        //        if destination == .RandomLocation {
        //            getRandomLocationWithCombine()
        //        }
    }
    
    @Published var position = MapCameraPosition
        .region(
            MKCoordinateRegion(
                center: MapConstants.DEFAULT_LOCATION,
                span: MapConstants.SPAN
            )
        )
    @Published var randomLocation = RandomLocation(
        lat: String(
            MapConstants.LAT
        ),
        long: String(
            MapConstants.LONG
        ),
        name: String(
            Strings.EMPTY
        )
    )
    @Published var alert: AlertModel? = nil
    
    func getUserLocation() {
        if let userLocation = locationHelper.getUserLocation() {
            self.position = MapCameraPosition.region(
                userLocation
            )
        } else {
            self.alert = AlertItem.unableToComplete
        }
    }
    
}

// MARK: Extension for fetching random location

extension MapScreenViewModel {
    
    @MainActor
    func getRandomLocation() async {
        do {
            let randomLocation = try await client.fetch(
                session: .shared
            )
            self.position = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: Double(
                            randomLocation.lat
                        ) ?? MapConstants.LAT,
                        longitude: Double(
                            randomLocation.long
                        ) ?? MapConstants.LONG
                    ),
                    span: MapConstants.SPAN
                )
            )
            self.randomLocation = randomLocation
        } catch {
            self.alert = alertHelper.errorToNetworkErrorAlert(
                error: error
            )
        }
    }
    
    private func getRandomLocationWithCombine() {
        do {
            try client.fetchWithCombine()
                .sink { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(
                        let error
                    ):
                        self.randomLocation.name = Strings.UNKNOWN
                        self.alert = self.alertHelper.errorToNetworkErrorAlert(
                            error: error
                        )
                    }
                } receiveValue: { [weak self] randomLocation in
                    self?.position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: Double(
                                    randomLocation.location.lat
                                ) ?? MapConstants.LAT,
                                longitude: Double(
                                    randomLocation.location.long
                                ) ?? MapConstants.LONG
                            ),
                            span: MapConstants.SPAN
                        )
                    )
                    self?.randomLocation = randomLocation.location
                }
                .store(
                    in: &cancellables
                )
        } catch {
            self.alert = alertHelper.errorToNetworkErrorAlert(
                error: error
            )
        }
    }
}
