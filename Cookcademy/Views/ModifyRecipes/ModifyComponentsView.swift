//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Oliver Hivale on 2/27/24.
//

import SwiftUI

protocol RecipeComponent {
  init()
}

protocol ModifyComponentView: View {
  associatedtype Component
  init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
          let addIngredientView = ModifyIngredientView(component: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient()
                }
          if ingredients.isEmpty {
            Spacer()
            NavigationLink("Add the first ingredient",
                           destination: addIngredientView)
            Spacer()
          } else {
            List {
              ForEach(ingredients.indices, id: \.self) { index in
                let ingredient = ingredients[index]
                Text(ingredient.description)
              }
              .listRowBackground(listBackgroundColor)
              NavigationLink("Add another ingredient",
                             destination: addIngredientView)
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(listBackgroundColor)
            }.foregroundColor(listTextColor)
          }
        }
    }
}

struct ModifyComponentsView_Previews: PreviewProvider {
  @State static var emptyIngredients = [Ingredient]()
  static var previews: some View {
    NavigationView {
      ModifyComponentsView<Ingredient, ModifyIngredientView>(ingredients: $emptyIngredients)
    }
    NavigationView {
      ModifyComponentsView<Ingredient, ModifyIngredientView>(ingredients: $recipe.ingredients)
    }
  }
}