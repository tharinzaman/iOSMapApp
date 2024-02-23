//
//  UITestingHelper.swift
//  MapApp
//
//  Created by Tharin Zaman on 23/02/2024.
//

import Foundation

struct UITestingHelper {
    
    static var isUITest: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var permissionGranted: Bool {
        ProcessInfo.processInfo.environment["-permission-granted"] == "1"
    }
    
    static var networkingSuccess: Bool {
        ProcessInfo.processInfo.environment["-networking-success"] == "1"
    }
    
}
