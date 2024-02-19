//
//  WelcomeView.swift
//  MapApp
//
//  Created by Tharin Zaman on 19/02/2024.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        VStackLayout(
            alignment: .center
        ) {
            Text(
                "WELCOME"
            )
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.blue)
            Image("Globe")
                .frame(height: 100)
            
            // TODO: Add in a text to ask where would you like to go
            Button {
                print("Going to get your location")
            } label: {
                Text(
                    "YOUR LOCATION"
                )
                .font(.body)
                .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    WelcomeScreen()
}
