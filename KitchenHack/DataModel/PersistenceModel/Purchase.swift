//
//  Purchase+CoreDataProperties.swift
//  KitchenHack
//
//  Created by Daniel Watson on 26/02/2021.
//
//

import Foundation
import CoreData

@objc(Purchase)
public class Purchase: NSManagedObject {

}

extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isFave: Bool
    @NSManaged public var price: String?
    @NSManaged public var qty: String?
    @NSManaged public var unit: String?
    @NSManaged public var ingredient: Ingredient
    @NSManaged public var supplier: Supplier

}

extension Purchase : Identifiable {

}
