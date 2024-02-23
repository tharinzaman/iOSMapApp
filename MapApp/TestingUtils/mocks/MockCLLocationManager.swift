//
//  MockLocationManager.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 22/02/2024.
//

import Foundation
import MapKit
@testable import MapApp

final class MockCLLocationManagerSuccess: CLLocationManager {
    
    override var location: CLLocation?  {
        return CLLocation(
            latitude: CLLocationDegrees(
                50
            ),
            longitude: CLLocationDegrees(
                50
            )
        )
    }
    
    override var desiredAccuracy: CLLocationAccuracy {
        get {
            return kCLLocationAccuracyBest
        }
        set {
            
        }
    }
    
    override var authorizationStatus: CLAuthorizationStatus {
        return .authorizedAlways
    }
    
    override func requestWhenInUseAuthorization() {
        return
    }
}

final class MockCLLocationManagerFailure: CLLocationManager {
    
    override var location: CLLocation?  {
        return nil
    }
    
    override var desiredAccuracy: CLLocationAccuracy {
        get {
            return 0.0
        }
        set {
            
        }
    }
    
    override var authorizationStatus: CLAuthorizationStatus {
        return .denied
    }
    
    override func requestWhenInUseAuthorization() {
        return
    }
}

