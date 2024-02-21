//
//  AlertHelperImpl.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation

protocol AlertHelper {
    
    func errorToUserLocationAlert(
        error: Error
    ) -> AlertModel
    
    func errorToNetworkError(
        error: Error
    ) -> AlertModel
    
}
