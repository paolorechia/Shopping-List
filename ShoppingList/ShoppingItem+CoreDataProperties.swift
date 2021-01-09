//
//  ShoppingItem+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//
//

import Foundation
import CoreData


extension ShoppingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItem> {
        return NSFetchRequest<ShoppingItem>(entityName: "ShoppingItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var priceUnit: Int32
    @NSManaged public var priceCents: Int32
    @NSManaged public var quantity: Int32
    @NSManaged public var brand: String?

}

extension ShoppingItem : Identifiable {

}
