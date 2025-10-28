//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  DiscoverViewController.swift
//  QuickDish
//
//  Created by Vardan Malik on 4/27/25.
//

import Foundation
import UIKit

// DiscoverViewController
// This view displays a random recipe.
// User can shuffle random recipes or start cooking.

class DiscoverViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    @IBOutlet weak var shuffleRecipeButton: UIButton!
    @IBOutlet weak var startCookingButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var recipes: [RecipeModel] = []
    var currentRecipe: RecipeModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleRecipes()
        showRandomRecipe()
        
        // Make background transparent so cornerRadius looks visible
        recipeImageView.backgroundColor = .clear
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 15
        recipeImageView.layer.masksToBounds = true
        recipeImageView.clipsToBounds = true
        
        // Round the corners of the buttons
        shuffleRecipeButton.layer.cornerRadius = 10
        startCookingButton.layer.cornerRadius = 10
    }

    // MARK: - Helper Methods

    func loadSampleRecipes() {
        recipes = RecipeDataProvider.loadSampleRecipes()
    }

    // Displays a random recipe from the recipes array
    func showRandomRecipe() {
        if let randomRecipe = recipes.randomElement() {
            currentRecipe = randomRecipe
            let isFav = CoreDataManager.shared.isRecipeFavorited(name: randomRecipe.name)
            currentRecipe?.isFavorite = isFav
            recipeTitleLabel.text = randomRecipe.name
            recipeDescriptionLabel.text = randomRecipe.description
            recipeImageView.image = UIImage(named: randomRecipe.imageName)
            updateFavoriteButton()
        }
    }

    // Update Heart Button Based on Favorite Status
    func updateFavoriteButton() {
        if currentRecipe?.isFavorite == true {
            let heartFilled = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            favoriteButton.setImage(heartFilled, for: .normal)
            favoriteButton.tintColor = .red
        } else {
            let heartEmpty = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            favoriteButton.setImage(heartEmpty, for: .normal)
            favoriteButton.tintColor = .white
        }
    }
    // Toggle Favorite Status
    func toggleFavorite() {
        if currentRecipe != nil {
            currentRecipe?.isFavorite.toggle()
            updateFavoriteButton()
        }
    }
    
    // MARK: - Actions

    // Called when the shuffle button is tapped
    @IBAction func shuffleRecipeButtonTapped(_ sender: UIButton) {
        showRandomRecipe()
    }

    @IBAction func startCookingButtonTapped(_ sender: UIButton) {
    }
    
    // Called when Favorite (Heart) button tapped
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        toggleFavorite()
        if let recipe = currentRecipe, recipe.isFavorite {
            CoreDataManager.shared.saveFavrite(recipe: recipe)
            } else if let recipe = currentRecipe {
                CoreDataManager.shared.deleteFavoriteRecipe(name: recipe.name)
            }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIngredients",
           let destinationVC = segue.destination as? IngredientsViewController {
            destinationVC.selectedRecipe = currentRecipe
        } else if segue.identifier == "show3DView",
                  let destinationVC = segue.destination as? Recipe3DViewController {
            destinationVC.recipeImageName = currentRecipe?.imageName
        }
    }


}
