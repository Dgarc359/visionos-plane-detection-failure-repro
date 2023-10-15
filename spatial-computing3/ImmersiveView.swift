//
//  ImmersiveView.swift
//  spatial-computing3
//
//  Created by David Garcia on 10/15/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

struct ImmersiveView: View {
    let session = ARKitSession()
    let planeData = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    
    @State var entityMap: [UUID: Entity] = [:]
    
    @State var rootEntity = ModelEntity()


    func updatePlane(_ anchor: PlaneAnchor) {
        if entityMap[anchor.id] == nil {
            // Add a new entity to represent this plane.
            let entity = ModelEntity(
                mesh: .generateText(anchor.classification.description)
            )
            
            entityMap[anchor.id] = entity
            rootEntity.addChild(entity)
        }
        
        entityMap[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
    }


    func removePlane(_ anchor: PlaneAnchor) {
        entityMap[anchor.id]?.removeFromParent()
        entityMap.removeValue(forKey: anchor.id)
    }

    
    var body: some View {
        RealityView { content in
            
            Task {
                try await session.run([planeData])
                
                for await update in planeData.anchorUpdates {
                    // Skip planes that are windows.
                    if update.anchor.classification == .window { continue }
                    
                    switch update.event {
                    case .added, .updated:
                        updatePlane(update.anchor)
                    case .removed:
                        removePlane(update.anchor)
                    }
                }
            
            // Add the initial RealityKit content
//            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
//                
//                let anchor = AnchorEntity(.plane([.horizontal, .vertical],
//                                                 classification: [.table, .floor],
//                                                  minimumBounds: [0.375, 0.375]))
//                let entity = ModelEntity(
//                    mesh: .generateText(anchor.classification.description)
//                )
//                
//                
//                
//                anchor.addChild(immersiveContentEntity)
//                content.add(anchor)
//
//                // Add an ImageBasedLight for the immersive content
//                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
//                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
//                immersiveContentEntity.components.set(iblComponent)
//                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))
//
//                // Put skybox here.  See example in World project available at
//                // https://developer.apple.com/
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
