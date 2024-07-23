//
//  BikeApp.swift
//  Bike
//
//  Created by Marlon Ruiz Arroyave on 18/07/24.
//

import SwiftUI

@main
struct BikeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
