//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Oliver Hivale on 2/27/24.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient(name: "",
                                                  quantity: 0.0,
                                                  unit: .none)
    
    var body: some View {
        VStack {
          let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient(name: "", quantity: 0.0, unit: .none)
                }
          if ingredients.isEmpty {
            Spacer()
            NavigationLink("Add the first ingredient",
                           destination: ModifyIngredientView(ingredient:
                                                              $newIngredient))
            Spacer()
          } else {
            List {
              ForEach(ingredients.indices, id: \.self) { index in
                let ingredient = ingredients[index]
                Text(ingredient.description)
              }
              NavigationLink("Add another ingredient",
                             destination: ModifyIngredientView(ingredient:
                                                                $newIngredient
                             ))
                .buttonStyle(PlainButtonStyle())
            }
          }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
  @State static var emptyIngredients = [Ingredient]()
  static var previews: some View {
    NavigationView {
      ModifyIngredientsView(ingredients: $emptyIngredients)
    }
  }
}
