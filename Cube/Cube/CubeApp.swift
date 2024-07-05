//
//  CubeApp.swift
//  Cube
//
//  Created by Marlon Ruiz Arroyave on 4/07/24.
//

import SwiftUI

@main
struct CubeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
