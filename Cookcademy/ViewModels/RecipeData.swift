//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Oliver Hivale on 11/19/23.
//

import Foundation

class RecipeData: ObservableObject {
  @Published var recipes = Recipe.testRecipes
}
