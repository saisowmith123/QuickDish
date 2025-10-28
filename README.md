# QuickDish

QuickDish is an iOS application that generates random recipes, allows users to favorite their preferred dishes, and provides detailed cooking instructions with interactive 3D visualizations of the final meal.

---

## Overview

QuickDish is your personal recipe companion that helps you discover something delicious with just a tap.  
Each time you open the app or hit **Shuffle Recipe**, you’re greeted with a new, randomly selected dish.

You can:
- View detailed ingredients and step-by-step cooking instructions.  
- Favorite recipes for quick access later.  
- Explore dishes in 3D interactive view using Apple's SceneKit.  

---

## Features

### Home / Discover Screen
- Displays a random recipe image, title, and short description.  
- **Shuffle Recipe** button to fetch a new random recipe.  
- **Start Cooking** button to navigate to ingredient and step instructions.  
- **3D Button** for an immersive SceneKit model of the dish.  
- **Heart Icon** to favorite or unfavorite a recipe.

### Favorites Screen
- Accessible via the bottom tab bar.  
- Displays all saved recipes (title, image, description).  
- Includes a search bar to find specific favorites.  
- **Cook!** button launches the recipe’s detailed instructions.  
- Persistent storage via Core Data, so favorites remain saved between app launches.

### Cooking Instructions Screen
- Shows preparation time, servings, and difficulty level.  
- Interactive checklist for ingredients.  
- Step-by-step instructions with a live cooking timer and progress bar.

### 3D Dish View
- Interactive 3D model of the recipe, rotatable using SceneKit.  
- Provides an engaging and detailed visual representation.

---

## Screenshots

<img width="180" height="330" alt="1" src="https://github.com/user-attachments/assets/dfeb99b4-4405-4d8f-9d3d-0dde47bd7c01" />
<img width="169" height="299" alt="2" src="https://github.com/user-attachments/assets/f4cda777-4007-482d-a62f-a9bd67878a96" />

---

## Architecture & Frameworks

- **Architecture Pattern:** Model-View-Controller (MVC)  
- **Persistence:** Core Data for local storage  
- **UI Framework:** UIKit  
- **3D Visualization:** SceneKit  
- **Animations:** Core Animation for smooth UI transitions  
- **Language:** Swift  
- **IDE:** Xcode 16.2  
- **Tested on:** iPhone SE (3rd Gen), iPhone 15, iPhone 16 Pro Max simulators and devices  

---
