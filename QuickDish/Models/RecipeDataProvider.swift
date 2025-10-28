//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  RecipeDataProvider.swift
//  QuickDish
//
//  Created by Vardan Malik on 5/5/25.
//

import Foundation

class RecipeDataProvider {
    static func loadSampleRecipes() -> [RecipeModel] {
        return [

            // 1) Creamy Pizza
            {
                let steps = [
                    "Preheat oven to 220°C (425°F).",
                    "Roll out pizza dough on a floured surface.",
                    "Spread creamy sauce evenly over the dough.",
                    "Top with shredded mozzarella and tomato slices.",
                    "Bake 12–15 minutes until crust is golden brown.",
                    "Garnish with fresh basil, slice, and serve."
                ]
                return RecipeModel(
                    name: "Creamy Pizza",
                    description: "Delicious cheesy pizza with a rich, creamy sauce.",
                    imageName: "pizza",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Pizza dough", "Cream sauce", "Mozzarella", "Tomatoes", "Fresh basil"],
                    prepTime: "20 min",
                    servings: 4,
                    difficulty: "Medium",
                    steps: steps
                )
            }(),

            // 2) Fresh Salad
            {
                let steps = [
                    "Wash and spin-dry the lettuce leaves.",
                    "Chop tomatoes, cucumber, and olives.",
                    "In a bowl, combine all chopped vegetables.",
                    "Drizzle vinaigrette and toss to coat.",
                    "Season with salt and pepper to taste.",
                    "Serve immediately or chill for 10 minutes."
                ]
                return RecipeModel(
                    name: "Fresh Salad",
                    description: "Crisp greens and veggies tossed in tangy vinaigrette.",
                    imageName: "salad",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Lettuce", "Tomatoes", "Cucumber", "Olives", "Vinaigrette"],
                    prepTime: "15 min",
                    servings: 2,
                    difficulty: "Easy",
                    steps: steps
                )
            }(),

            // 3) Spaghetti Bolognese
            {
                let steps = [
                    "Bring a large pot of salted water to a boil.",
                    "Cook spaghetti until al dente, then drain.",
                    "In a skillet, sauté onion and garlic in olive oil.",
                    "Add ground beef and cook until browned.",
                    "Stir in tomato sauce and simmer 10 minutes.",
                    "Combine pasta with sauce, top with Parmesan."
                ]
                return RecipeModel(
                    name: "Spaghetti Bolognese",
                    description: "Classic Italian pasta in a rich meat sauce.",
                    imageName: "spaghetti",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Spaghetti", "Ground beef", "Tomato sauce", "Onion", "Garlic"],
                    prepTime: "40 min",
                    servings: 4,
                    difficulty: "Medium",
                    steps: steps
                )
            }(),

            // 4) Grilled Cheese Sandwich
            {
                let steps = [
                    "Butter one side of each bread slice.",
                    "Heat a skillet over medium heat.",
                    "Place bread butter-side-down, add cheese, top with second slice.",
                    "Cook 2–3 minutes per side until golden and cheese melts.",
                    "Remove, slice diagonally, and serve hot."
                ]
                return RecipeModel(
                    name: "Grilled Cheese Sandwich",
                    description: "Golden brown, melty cheddar between crisp bread.",
                    imageName: "grilled_cheese",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Bread slices", "Butter", "Cheddar cheese"],
                    prepTime: "10 min",
                    servings: 1,
                    difficulty: "Easy",
                    steps: steps
                )
            }(),

            // 5) Pancakes
            {
                let steps = [
                    "Whisk flour, baking powder, sugar, and salt in a bowl.",
                    "In another bowl, beat eggs, milk, and melted butter.",
                    "Pour wet mix into dry, stir until just combined.",
                    "Heat non-stick pan, pour ¼ cup batter per pancake.",
                    "Flip when bubbles form, cook 1–2 more minutes.",
                    "Stack pancakes, drizzle maple syrup, and serve."
                ]
                return RecipeModel(
                    name: "Pancakes",
                    description: "Fluffy breakfast stacks perfect with syrup.",
                    imageName: "pancakes",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Flour", "Baking powder", "Sugar", "Milk", "Eggs", "Butter", "Maple syrup"],
                    prepTime: "25 min",
                    servings: 4,
                    difficulty: "Easy",
                    steps: steps
                )
            }(),

            // 6) Tomato Soup
            {
                let steps = [
                    "Heat oil and sauté onion and garlic until soft.",
                    "Add chopped tomatoes, cook 5 minutes.",
                    "Pour in vegetable broth, simmer 10 minutes.",
                    "Blend until smooth, return to pot.",
                    "Stir in cream, season with salt and pepper.",
                    "Garnish with basil and serve warm."
                ]
                return RecipeModel(
                    name: "Tomato Soup",
                    description: "Creamy, comforting tomato soup.",
                    imageName: "tomato_soup",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Tomatoes", "Onion", "Garlic", "Vegetable broth", "Cream"],
                    prepTime: "30 min",
                    servings: 4,
                    difficulty: "Medium",
                    steps: steps
                )
            }(),

            // 7) Chicken Tacos
            {
                let steps = [
                    "Season chicken with chili powder, cumin, salt, and pepper.",
                    "Grill or pan-sear chicken until fully cooked.",
                    "Warm tortillas in a dry skillet.",
                    "Slice chicken and fill each tortilla.",
                    "Top with lettuce, salsa, and shredded cheese.",
                    "Serve with lime wedges."
                ]
                return RecipeModel(
                    name: "Chicken Tacos",
                    description: "Spiced chicken tucked into warm tortillas.",
                    imageName: "chicken_tacos",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Chicken breast", "Tortillas", "Lettuce", "Salsa", "Cheddar cheese"],
                    prepTime: "20 min",
                    servings: 4,
                    difficulty: "Medium",
                    steps: steps
                )
            }(),

            // 8) Fruit Smoothie
            {
                let steps = [
                    "Peel banana and wash berries.",
                    "Add fruit, yogurt, honey, and milk to blender.",
                    "Blend until smooth and creamy.",
                    "Pour into glasses and garnish with mint."
                ]
                return RecipeModel(
                    name: "Fruit Smoothie",
                    description: "Bright, creamy blend of banana and berries.",
                    imageName: "smoothie",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Banana", "Mixed berries", "Yogurt", "Honey", "Milk"],
                    prepTime: "10 min",
                    servings: 2,
                    difficulty: "Easy",
                    steps: steps
                )
            }(),

            // 9) Veggie Stir Fry
            {
                let steps = [
                    "Slice broccoli, carrots, and bell peppers.",
                    "Heat oil in wok, sauté garlic and ginger.",
                    "Add vegetables, stir-fry until crisp-tender.",
                    "Stir in soy sauce and sesame oil.",
                    "Cook 1–2 more minutes, then serve over rice."
                ]
                return RecipeModel(
                    name: "Veggie Stir Fry",
                    description: "Quick, colorful veggies in savory sauce.",
                    imageName: "stir_fry",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Broccoli", "Carrots", "Bell pepper", "Garlic", "Ginger", "Soy sauce"],
                    prepTime: "20 min",
                    servings: 4,
                    difficulty: "Easy",
                    steps: steps
                )
            }(),

            // 10) Chocolate Brownies
            {
                let steps = [
                    "Preheat oven to 180°C (350°F).",
                    "Melt butter and chocolate over a double boiler.",
                    "Stir in sugar until dissolved.",
                    "Beat in eggs one at a time.",
                    "Fold in flour and cocoa powder gently.",
                    "Pour into a greased pan and bake 20–25 minutes.",
                    "Let cool completely before slicing."
                ]
                return RecipeModel(
                    name: "Chocolate Brownies",
                    description: "Rich, fudgy brownies with crisp edges.",
                    imageName: "brownies",
                    instructions: steps
                        .enumerated()
                        .map { "Step \($0 + 1): \($1)" }
                        .joined(separator: "\n"),
                    ingredients: ["Dark chocolate", "Butter", "Sugar", "Eggs", "Flour", "Cocoa powder"],
                    prepTime: "40 min",
                    servings: 8,
                    difficulty: "Medium",
                    steps: steps
                )
            }()

        ]
    }
}
