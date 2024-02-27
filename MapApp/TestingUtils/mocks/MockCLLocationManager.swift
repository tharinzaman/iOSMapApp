//
//  MockLocationManager.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 22/02/2024.
//

import Foundation
import MapKit

final class MockCLLocationManagerSuccess: LocationManager {
    
    var location: CLLocation?  {
        return CLLocation(
            latitude: CLLocationDegrees(
                50
            ),
            longitude: CLLocationDegrees(
                50
            )
        )
    }
    
    var desiredAccuracy: CLLocationAccuracy {
        get {
            return kCLLocationAccuracyBest
        }
        set {
            
        }
    }
    
    var authorizationStatus: CLAuthorizationStatus {
        return .authorizedAlways
    }
    
    func requestWhenInUseAuthorization() {
        return
    }
}

final class MockCLLocationManagerFailure: LocationManager {
    
    var location: CLLocation?  {
        return nil
    }
    
    var desiredAccuracy: CLLocationAccuracy {
        get {
            return 0.0
        }
        set {
            
        }
    }
    
    var authorizationStatus: CLAuthorizationStatus {
        return .denied
    }
    
    func requestWhenInUseAuthorization() {
        return
    }
}

