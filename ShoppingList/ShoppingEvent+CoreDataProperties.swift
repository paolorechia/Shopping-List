//
//  ShoppingEvent+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//
//

import Foundation
import CoreData


extension ShoppingEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingEvent> {
        return NSFetchRequest<ShoppingEvent>(entityName: "ShoppingEvent")
    }

    @NSManaged public var dateOfEvent: Date?
    @NSManaged public var shoppingItems: NSSet?

}

// MARK: Generated accessors for shoppingItems
extension ShoppingEvent {

    @objc(addShoppingItemsObject:)
    @NSManaged public func addToShoppingItems(_ value: ShoppingItem)

    @objc(removeShoppingItemsObject:)
    @NSManaged public func removeFromShoppingItems(_ value: ShoppingItem)

    @objc(addShoppingItems:)
    @NSManaged public func addToShoppingItems(_ values: NSSet)

    @objc(removeShoppingItems:)
    @NSManaged public func removeFromShoppingItems(_ values: NSSet)

}

extension ShoppingEvent : Identifiable {

}
