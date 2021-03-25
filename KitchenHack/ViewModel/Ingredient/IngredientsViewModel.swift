//
//  IngredientsView.swift
//  KitchenHack
//
//  Created by Daniel Watson on 25/02/2021.
//

import SwiftUI

class IngredientsViewModel: ObservableObject {
    var dataModel = IngredientControlModel()
    @Published var ingredients = [Ingredient]()
    @Published var showAddNewIngredientSheet = false
    @Published var showNoCurrentSupplierAlert = false
    @Published var name = ""
    @Published var pickerIndex = 0
    @Published var showList: ListType = .supplier
    var suppliers = [Supplier]()
    
    func Create() {
        let ingredient = Ingredient(context: dataModel.moc)
        ingredient.name = name
        let supplier = suppliers[pickerIndex]
        dataModel.CreateIngredient(ingredient, supplier)
        Read()
    }
    func Read() {
        ingredients = dataModel.Read(.ingredient) as! [Ingredient]
        suppliers = dataModel.Read(.supplier) as! [Supplier]
    }
    func Update(_ ingredient: Ingredient) {
        let fields = ["name" : name]
        for (key, value) in fields {
            dataModel.UpdateIngredient(ingredient, key: key, value: value)
        }
    }
    func Delete(indexSet: IndexSet) {
        for index in indexSet {
            let obj = ingredients[index]
            dataModel.Delete(obj)
            
            let index = ingredients.firstIndex(of: obj)
            ingredients.remove(at: index!)
        }
    }
    func GuardSheet() {
            if suppliers.isEmpty {
                self.showNoCurrentSupplierAlert = true
            } else {
                self.showAddNewIngredientSheet = true
            }
        }
    init() {
        Read()
    }
    enum ListType {
        case supplier, list
    }
}


