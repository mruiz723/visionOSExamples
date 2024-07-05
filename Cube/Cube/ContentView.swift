//
//  ContentView.swift
//  Cube
//
//  Created by Marlon Ruiz Arroyave on 4/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var showImmersiveSpace = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
        
    var body: some View {
        NavigationStack {
            VStack {
                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
            }
        }
        .onChange(of: showImmersiveSpace) { _, isImmersiveSpace in
            Task {
                if isImmersiveSpace {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
