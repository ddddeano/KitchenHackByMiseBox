//
//  Supplier+CoreDataProperties.swift
//  KitchenHack
//
//  Created by Daniel Watson on 26/02/2021.
//
//

import Foundation
import CoreData

@objc(Supplier)
public class Supplier: NSManagedObject {

}

extension Supplier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Supplier> {
        return NSFetchRequest<Supplier>(entityName: "Supplier")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var purchases: NSSet?
    
    public var wrappedName: String {
        name ?? "unknown"
    }
    
    public var wrappedEmail: String {
        email ?? "unknown"
    }
    public var purchaseArray: [Purchase] {
        let set = purchases as? Set<Purchase> ?? []
        
        return set.sorted {
            $0.ingredient.wrappedName < $1.ingredient.wrappedName
        }
    }

}

// MARK: Generated accessors for ingredients
extension Supplier {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for purchases
extension Supplier {

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: Purchase)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: Purchase)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSSet)

}

extension Supplier : Identifiable {

}
