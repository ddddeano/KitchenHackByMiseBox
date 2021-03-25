//
//  Ingredient+CoreDataProperties.swift
//  KitchenHack
//
//  Created by Daniel Watson on 26/02/2021.
//
//

import Foundation
import CoreData

@objc(Ingredient)
public class Ingredient: NSManagedObject {

}

extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var purchases: NSSet?
    @NSManaged public var suppliers: NSSet?
    
    public var wrappedName: String {
        name ?? "unknown"
    }
    
    public var supplierArray: [Supplier] {
        let set = suppliers as? Set<Supplier> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var purchaseArray: [Purchase] {
        let set = purchases as? Set<Purchase> ?? []
        
        return set.sorted {
            $0.supplier.wrappedName < $1.supplier.wrappedName
        }
    }

}

// MARK: Generated accessors for purchases
extension Ingredient {

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: Purchase)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: Purchase)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSSet)

}

// MARK: Generated accessors for suppliers
extension Ingredient {

    @objc(addSuppliersObject:)
    @NSManaged public func addToSuppliers(_ value: Supplier)

    @objc(removeSuppliersObject:)
    @NSManaged public func removeFromSuppliers(_ value: Supplier)

    @objc(addSuppliers:)
    @NSManaged public func addToSuppliers(_ values: NSSet)

    @objc(removeSuppliers:)
    @NSManaged public func removeFromSuppliers(_ values: NSSet)

}

extension Ingredient : Identifiable {

}
