//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  CoreDataManager.swift
//  QuickDish
//
//  Created by Saisowmith Reddy Katkuri on 4/29/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    // Initializes and loads the Core Data persistent container.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipeModel")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Returns the current Core Data context for operations.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Saves a recipe to favorites if it's not already added.
    func saveFavrite(recipe: RecipeModel){
        let context = persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "name == %@", recipe.name)

           do {
               let existing = try context.fetch(fetchRequest)
               if existing.isEmpty {
                   let favorite = FavoriteRecipe(context: context)
                   favorite.name = recipe.name
                   favorite.descriptionText = recipe.description
                   favorite.imageName = recipe.imageName
                   favorite.instructions = recipe.instructions

                   try context.save()
               } else {
                   print("Recipe '\(recipe.name)' already exists in favorites.")
               }
           } catch {
               print("Failed to save favorite: \(error)")
           }
        
    }
    
    // Saves changes in the Core Data context if needed.
    func saveContext() {
        if context.hasChanges{
            try? context.save()
        }
    }
    
    // Fetches all saved favorite recipes from Core Data.
    func fetchFavoriteRecipes() -> [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
            let results = (try? context.fetch(request)) ?? []
            print("Total favorites fetched: \(results.count)")
            return results
    }
    
    // Deletes a favorite recipe matching the given name.
    func deleteFavoriteRecipe(name: String){
//        print("hello")
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        if let result = try? context.fetch(request){
            for object in result {
                context.delete(object)
            }
            saveContext()
        }
        
    }
    
    // Checks if a recipe is already in favorites by name.
    func isRecipeFavorited(name: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        return (try? context.fetch(request))?.first != nil
    }

    
    // Function to delete all favorites if required
//    func deleteAllFavorites() {
//        let context = persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteRecipe.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(batchDeleteRequest)
//            try context.save()
//            print("All favorites deleted.")
//        } catch {
//            print("Failed to delete all favorites: \(error)")
//        }
//    }

}

    
    
    

  
