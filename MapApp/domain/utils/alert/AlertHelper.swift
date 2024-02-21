//
//  AlertHelperImpl.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation

protocol AlertHelper {
    
    func errorToUserLocationErrorAlert(
        error: Error
    ) -> AlertModel
    
    func errorToNetworkErrorAlert(
        error: Error
    ) -> AlertModel
    
}
