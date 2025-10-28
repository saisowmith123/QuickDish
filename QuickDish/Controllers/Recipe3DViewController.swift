//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  Recipe3DViewController.swift
//  QuickDish
//
//  Created by Saisowmith Reddy Katkuri on 4/30/25.
//

import Foundation
import UIKit

class Recipe3DViewController:UIViewController
{
    // Holds the image name to load the corresponding 3D model.
    var recipeImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let dishView = Dish3DView(frame: view.bounds)
        dishView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(dishView)
        
        // Loads the 3D model if an image name was provided.
        if let imageName = recipeImageName {
            dishView.loadModel(for: imageName)
        }
    }
}
