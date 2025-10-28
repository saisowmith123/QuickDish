//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  Dish3DView.swift
//  QuickDish
//
//  Created by Saisowmith Reddy Katkuri on 4/30/25.
//

import Foundation
import SceneKit
import UIKit

class Dish3DView: SCNView {
    
    override init(frame: CGRect) {
        super.init(frame: frame, options: nil)
        setupScene()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setupScene()
    }

    // Sets up the SceneKit scene, camera, lighting, and background.
    private func setupScene() {
        let scene = SCNScene()
        self.scene = scene
        self.allowsCameraControl = true
        self.autoenablesDefaultLighting = true
        self.backgroundColor = .black

            
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 3)
        scene.rootNode.addChildNode(cameraNode)

        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 10, 10)
        scene.rootNode.addChildNode(lightNode)
    }
    
    // Loads and displays a .usdz 3D model for the given recipe name.
    func loadModel(for recipe: String) {
        guard let sceneURL = Bundle.main.url(forResource: recipe, withExtension: "usdz"),
              let modelScene = try? SCNScene(url: sceneURL, options: nil) else {
            print("Could not load model for \(recipe)")
            return
        }

        let modelNode = modelScene.rootNode.clone()
    
        let (minVec, maxVec) = modelNode.boundingBox
        let sizeX = maxVec.x - minVec.x
        let sizeY = maxVec.y - minVec.y
        let sizeZ = maxVec.z - minVec.z
        let maxDimension = max(sizeX, sizeY, sizeZ)

        let targetSize: Float = 1.5

        let scaleFactor = targetSize / maxDimension
        modelNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)


        let centerX = (minVec.x + maxVec.x) / 2
        let centerY = (minVec.y + maxVec.y) / 2
        let centerZ = (minVec.z + maxVec.z) / 2
        modelNode.pivot = SCNMatrix4MakeTranslation(centerX, centerY, centerZ)
        modelNode.position = SCNVector3(0, 0, 0)

        self.scene?.rootNode.addChildNode(modelNode)
    }


}

