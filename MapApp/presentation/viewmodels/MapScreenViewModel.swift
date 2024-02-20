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
    
    private let locationHelper: UserLocationHelperProtocol
    private let client: NetworkClientProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        locationHelper: UserLocationHelperProtocol,
        client: NetworkClientProtocol,
        destination: Destination
    ) {
        self.locationHelper = locationHelper
        self.client = client
        // MARK: Uncomment/Comment the following lines if you want/don't want to use combine
        if destination == .RandomLocation {
            getRandomLocationWithCombine()
        }
    }
    
    @Published var position = MapCameraPosition
        .region(
            MKCoordinateRegion(
                center: MapConstants.defaultLocation,
                span: MapConstants.span
            )
        )
    @Published var randomLocation = RandomLocation(
        lat: String(MapConstants.lat),
        long: String(MapConstants.long),
        name: String(Strings.Empty)
    )
    
    func getUserLocation() {
        if locationHelper.checkIfLocationPermissionsAreGranted() {
            if let userLocation = locationHelper.getUserLocation() {
                self.position = MapCameraPosition.region(
                    userLocation
                )
            }
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
                        latitude: Double(randomLocation.lat) ?? MapConstants.lat,
                        longitude: Double(randomLocation.long) ?? MapConstants.long
                    ),
                    span: MapConstants.span
                )
            )
            self.randomLocation = randomLocation
        } catch {
            // TODO: Generate an alert
            print(
                "Error: \(error.localizedDescription)"
            )
        }
    }
    
    private func getRandomLocationWithCombine() {
        do {
            try client.fetchWithCombine()
                .sink { completion in
                    switch completion {
                    case .finished:
                        // Don't actually need to do anything
                        print("Finished")
                    case .failure(_):
                        self.randomLocation.name = Strings.Unknown
                    }
                } receiveValue: { [weak self] randomLocation in
                    self?.randomLocation = randomLocation.location
                    self?.position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: Double(randomLocation.location.lat) ?? MapConstants.lat,
                                longitude: Double(randomLocation.location.long) ?? MapConstants.long
                            ),
                            span: MapConstants.span
                        )
                    )
                }
                .store(
                    in: &cancellables
                )
        } catch {
            // TODO: Generate an alert
            print("Error: \(error.localizedDescription)")
        }
    }
}
