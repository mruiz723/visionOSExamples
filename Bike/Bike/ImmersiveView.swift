//
//  ImmersiveView.swift
//  Bike
//
//  Created by Marlon Ruiz Arroyave on 18/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State var bikeViewModel = BikeViewModel()
    @State var bike = Entity()
    @State var modelEntity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            content.add(bikeViewModel.setupContentEntity())
            Task {
                DispatchQueue.main.async {
                    bike = bikeViewModel.addBike(name: "Bike")
                    // Find the specific ModelEntity you want to interact with
                    if let entity = bike.findEntity(named: "defaultMaterial_007")?.findEntity(named: "defaultMaterial_001") as? ModelEntity {
                        modelEntity = entity
                    }
                }
            }
        }
        .gesture(
            DragGesture()
                .targetedToEntity(bike)
                .onChanged { value in
                    let newPosition = value.convert(
                        value.location3D,
                        from: .local,
                        to: bike.parent!
                    )
                    bike.position = newPosition
                }
        )
        .gesture(
            SpatialTapGesture()
                .targetedToEntity(bike)
                .onEnded { _ in
                    bikeViewModel.changeToRandomColor(entity: modelEntity)
                }
        )
        .onDisappear {
            bikeViewModel.cleanup()
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
