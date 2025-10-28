//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  RecipeModel.swift
//  QuickDish
//
//  Created by Vardan Malik on 4/27/25.
//

import Foundation

struct RecipeModel {
    let name: String
    let description: String
    let imageName: String

    let instructions: String

    let ingredients: [String]

    let prepTime: String       // e.g. "10 min"
    let servings: Int          // e.g. 4
    let difficulty: String     // "Easy" / "Medium" / "Hard"

    let steps: [String]

    var isFavorite: Bool = false
}
