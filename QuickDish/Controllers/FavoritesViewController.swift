//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  FavoritesViewController.swift
//  QuickDish
//
//  Created by Saisowmith Reddy Katkuri on 4/29/25.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FavoriteTableViewCellDelegate, UISearchResultsUpdating {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteRecipe: [FavoriteRecipe] = []
    var filteredFavorites: [FavoriteRecipe] = []
    var selectedRecipe: FavoriteRecipe?
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchActive: Bool {
        return !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    // Sets up search bar appearance, fetches favorites, and reloads the table.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(
            string: "Search Recipes",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
                
        if let leftIconView = textField.leftView as? UIImageView {
                leftIconView.tintColor = .white
            }
        }

        // Fetch and reload favorites
        favoriteRecipe = CoreDataManager.shared.fetchFavoriteRecipes()
        tableView.reloadData()
    }

    // Refreshes favorite recipes list every time the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipe = CoreDataManager.shared.fetchFavoriteRecipes()
        tableView.reloadData()
    }

    // Returns number of rows based on whether search is active.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredFavorites.count : favoriteRecipe.count
    }
    
    // Configures each table cell with recipe data and sets up button callbacks.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let recipe = isSearchActive ? filteredFavorites[indexPath.row] : favoriteRecipe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        cell.delegate = self
        cell.titleLabel.text = recipe.name
        cell.descriptionLabel.text = recipe.descriptionText
        cell.recipeImageView.image = UIImage(named: recipe.imageName ?? "")
        cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.heartButton.tintColor = .red
        cell.onUnfavoriteTapped = { [weak self] in
            guard let self = self else { return }
            CoreDataManager.shared.deleteFavoriteRecipe(name: recipe.name ?? "")
            self.favoriteRecipe = CoreDataManager.shared.fetchFavoriteRecipes()
            self.tableView.reloadData()
        }
        cell.onStartCookingTapped = { [weak self] in
            guard let self = self else { return }
            self.selectedRecipe = recipe
            self.performSegue(withIdentifier: "showIngredientsFromFavorites", sender: nil)
        }

        return cell
    }
    
    // Animates and removes recipe when heart button is tapped used CoreAnimations
    func didTapHeart(on cell: FavoriteTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let recipe = favoriteRecipe[indexPath.row]
        let flipAnimation = CATransition()
        flipAnimation.type = .fade
        flipAnimation.subtype = .fromTop
        flipAnimation.duration = 0.3
        cell.heartButton.layer.add(flipAnimation, forKey: "flip")
        cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        cell.heartButton.tintColor = .white
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            CoreDataManager.shared.deleteFavoriteRecipe(name: recipe.name ?? "")
            self.favoriteRecipe.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1
        fade.toValue = 0
        fade.duration = 0.4
        fade.fillMode = .forwards
        fade.isRemovedOnCompletion = false
        let slide = CABasicAnimation(keyPath: "transform.translation.x")
        slide.fromValue = 0
        slide.toValue = -cell.frame.width
        slide.duration = 0.4
        slide.fillMode = .forwards
        slide.isRemovedOnCompletion = false
        cell.layer.add(fade, forKey: "fade")
        cell.layer.add(slide, forKey: "slide")
        CATransaction.commit()
    }
    
    // Filters recipes as the user types into the search bar.
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredFavorites = []
            tableView.reloadData()
            return }
        filteredFavorites = favoriteRecipe.filter {
            recipe in return recipe.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        tableView.reloadData()
    }
    
    // Prepares the IngredientsViewController with the selected recipe to display.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIngredientsFromFavorites",
           let destinationVC = segue.destination as? IngredientsViewController {

            if let favRecipe = selectedRecipe {
                let fullRecipe = RecipeDataProvider.loadSampleRecipes().first(where: { $0.name == favRecipe.name })

                if let fullRecipe = fullRecipe {
                    destinationVC.selectedRecipe = fullRecipe
                } else {
                    
                    let minimalRecipe = RecipeModel(
                        name: favRecipe.name ?? "",
                        description: favRecipe.descriptionText ?? "",
                        imageName: favRecipe.imageName ?? "",
                        instructions: favRecipe.instructions ?? "",
                        ingredients: [],
                        prepTime: "",
                        servings: 0,
                        difficulty: "",
                        steps: []
                    )
                    destinationVC.selectedRecipe = minimalRecipe
                }
            }
        }
    }




}
