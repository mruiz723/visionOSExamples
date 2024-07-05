//
//  ImmersiveView.swift
//  Cube
//
//  Created by Marlon Ruiz Arroyave on 4/07/24.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    
    @State var cubeViewModel = CubeViewModel()
    @State var cube = Entity()
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            content.add(cubeViewModel.setupContentEntity())
            cube = cubeViewModel.addCube(name: "Cube")
        }
        .gesture(
            DragGesture()
                .targetedToEntity(cube)
                .onChanged { value in
                    let newPosition = value.convert(
                        value.location3D,
                        from: .local,
                        to: cube.parent!
                    )
                    cube.position = newPosition
                }
        )
        .gesture(
            SpatialTapGesture()
                .targetedToEntity(cube)
                .onEnded { _ in
                    cubeViewModel.changeToRandomColor(entity: cube)
                }
        )
        .onDisappear {
            cubeViewModel.cleanup()
        }
    }
    
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
