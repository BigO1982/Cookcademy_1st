//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Oliver Hivale on 11/27/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @Binding var recipe: Recipe
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @State private var isPresenting = false
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")\(direction.description)")
                                
                            }.foregroundColor(listTextColor)
                        }
                    }.listRowBackground(listBackgroundColor)
                }
            }
            .navigationTitle(recipe.mainInformation.name)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button("Edit") {
                            isPresenting = true
                        }
                        Button(action: {
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                NavigationView {
                    ModifyRecipeView(recipe: $recipe)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    isPresenting = false
                                }
                            }
                        }
                        .navigationTitle("Edit Recipe")
                }
                .onDisappear {
                  recipeData.saveRecipes()
                }
            }
        }
    }
}
struct RecipeDetailView_Previews: PreviewProvider {
  @State static var recipe = Recipe.testRecipes[0]
  static var previews: some View {
    NavigationView {
      RecipeDetailView(recipe: $recipe)
    }
  }
}

