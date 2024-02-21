//
//  Alert.swift
//  MapApp
//
//  Created by Tharin Zaman on 21/02/2024.
//

import SwiftUI

struct AlertModel: Identifiable {
    
    init(
        title: String,
        message: String
    ) {
        self.title = Text(
            title
        )
        self.message = Text(
            message
        )
    }
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton = Alert.Button.default(
        Text(
            Strings.OK
        )
    )
}
