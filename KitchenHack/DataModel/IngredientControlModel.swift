//
//  IngredientControlModel.swift
//  KitchenHack
//
//  Created by Daniel Watson on 13/03/2021.
//

import SwiftUI
import CoreData
import Combine

class IngredientControlModel: ObservableObject {
    let moc = pC.viewContext
    enum ControlType: String {
        case supplier = "Supplier"
        case ingredient = "Ingredient"
        case purchase = "Purchase"
    }
    //    Create
    func CreateSupplier(_ supplier: Supplier) {
        let supplierMoc = Supplier(context: self.moc)
        supplierMoc.id = UUID()
        supplierMoc.name = supplier.name
        try? self.moc.save()
    }
    func CreateIngredient(_ ingredient: Ingredient,_ supplier: Supplier) {
        let ingredientMoc = Ingredient(context: self.moc)
        ingredientMoc.id = UUID()
        ingredientMoc.name = ingredient.name
        supplier.addToIngredients(ingredient)
        CreatePurchase(ingredient, supplier)
        try? self.moc.save()
    }
    func CreatePurchase(_ ingredient: Ingredient,_ supplier: Supplier) {
        let purchaseMoc = Purchase(context: self.moc)
        purchaseMoc.id = UUID()
        purchaseMoc.ingredient = ingredient
        purchaseMoc.supplier = supplier
        try? self.moc.save()
    }
    //    Read
    func Read(_ type: ControlType) -> [Any] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: type.rawValue)
        guard let results = try? moc.fetch(request) else { return [] }
        return results
    }
    // Update
    
    func UpdateSupplier(_ supplier: Supplier, key: String, value: String) {
        supplier.setValue(value, forKey: key)
        try? self.moc.save()
    }
    func UpdateIngredient(_ ingredient: Ingredient, key: String, value: String) {
        ingredient.setValue(value, forKey: key)
        try? self.moc.save()
    }
    
    // Delete
    func Delete(_ obj: NSManagedObject)  {
        do {
            self.moc.delete(obj)
            try self.moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}


