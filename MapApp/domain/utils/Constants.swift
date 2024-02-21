//
//  Constants.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import Foundation
import MapKit

struct MapConstants {
    
    static let SPAN = MKCoordinateSpan(
        latitudeDelta: 0.01,
        longitudeDelta: 0.01
    )
    static let DEFAULT_LOCATION = CLLocationCoordinate2D(
        latitude: 0.0,
        longitude: 0.0
    )
    
    static let LAT = 0.0
    static let LONG = 0.0
}

struct Strings {
    
    static let EMPTY = ""
    
    static let UNKNOWN = "Unknown"
    static let OK = "OK"
    
    static let WELCOME = "WELCOME"
    static let WHERE_TO = "WHERE TO?"
    static let MY_LOCATION = "MY LOCATION"
    static let RANDOM_LOCATION = "RANDOM LOCATION"
        
}
