//
//  BikeViewModel.swift
//  Bike
//
//  Created by Marlon Ruiz Arroyave on 18/07/24.
//

import SwiftUI
import RealityKit

@Observable
class BikeViewModel {
    
    private var bike: Entity?
    private var contentEntity: Entity = Entity()
    private let colors: [SimpleMaterial.Color] = [.gray, .red, .orange, .yellow, .green, .blue, .purple, .systemPink]
    
    func setupContentEntity() -> Entity {
        return contentEntity
    }
    
    func getTargetEntity(name: String) -> Entity? {
        return contentEntity.children.first { $0.name == name}
    }
    
    func 
    addBike(name: String) -> Entity {
        do {
            let entity = try Entity.load(named: "night_rod")
            entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            entity.name = name
            
            entity.generateCollisionShapes(recursive: true)
            
            let modelEntity = entity.findEntity(named: "defaultMaterial_007")?.findEntity(named: "defaultMaterial_001") as? ModelEntity
            modelEntity?.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        
            // Define bit masks for collision groups and masks
            let bikeCollisionGroup: CollisionGroup = .init(rawValue: 1 << 0)
            let obstacleCollisionGroup: CollisionGroup = .init(rawValue: 1 << 1)
            let allCollisionGroups: CollisionGroup = [bikeCollisionGroup, obstacleCollisionGroup]
            
            // Create a collision component with the defined group and mask
            let bikeCollisionFilter = CollisionFilter(group: bikeCollisionGroup, mask: allCollisionGroups)
            var collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)])
            collision.filter = bikeCollisionFilter
            entity.components.set(collision)
            
            modelEntity?.components.set(collision)
            
            // Create a physics material with specified friction and restitution
            let material = PhysicsMaterialResource.generate(friction: 0.8, restitution: 0.0)
            
            // Create a physics body component using the collision shapes
            let physicsBody = PhysicsBodyComponent(shapes: collision.shapes,
                                                   mass: 0.0,
                                                   material: material,
                                                   mode: .dynamic)
            entity.components.set(physicsBody)
            modelEntity?.components.set(physicsBody)
            
            entity.position = SIMD3(x: 0, y: 1, z: -2)
            entity.setScale(.init(x: 0.05, y: 0.05, z: 0.05), relativeTo: nil)
            contentEntity.addChild(entity)
            self.bike = entity
            return entity
        } catch {
            print("error: \(error.localizedDescription)")
            fatalError("An entity is required")
        }
    }
    
    func changeToRandomColor(entity: Entity) {
        guard let _entity = entity as? ModelEntity else { return }
//        _entity.model?.materials = [SimpleMaterial(color: colors.randomElement()!, isMetallic: false)]
        _entity.model?.materials = [SimpleMaterial(color: UIColor.random, isMetallic: false)]
    }
    
    func cleanup() {
        // Perform cleanup actions
        bike?.removeFromParent()
        bike = nil
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
