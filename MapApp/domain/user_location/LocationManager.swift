//
//  LocationManager.swift
//  MapApp
//
//  Created by Tharin Zaman on 27/02/2024.
//

import Foundation
import MapKit

protocol LocationManager {
    
    var location: CLLocation? {get}
    var desiredAccuracy: CLLocationAccuracy {get set}
    var authorizationStatus: CLAuthorizationStatus {get}
    func requestWhenInUseAuthorization()
    
}
