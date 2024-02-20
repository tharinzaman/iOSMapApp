//
//  Constants.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

enum MapConstants {
    
    static let span = MKCoordinateSpan(
        latitudeDelta: 0.01,
        longitudeDelta: 0.01
    )
    static let defaultLocation = CLLocationCoordinate2D(
        latitude: 0,
        longitude: 0
    )

}

enum Strings {
    
    static let Welcome = "WELCOME"
    static let WhereTo = "WHERE TO?"
    static let MyLocation = "MY LOCATION"
    static let RandomLocation = "RANDOM LOCATION"
    
}
