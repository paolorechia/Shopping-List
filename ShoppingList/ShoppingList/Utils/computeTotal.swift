//
//  computeTotal.swift
//  ShoppingList
//
//  Created by Paolo on 10/01/21.
//

import Foundation


class ComputeTotal {
    static var totalPriceUnits: Int32 = 0
    static var totalPriceCents: Int32 = 0
    
    static func update_totals(items: [ShoppingItem]) {
        totalPriceUnits = 0
        totalPriceCents = 0
        for item in items {
            totalPriceUnits += item.priceUnit
            totalPriceCents += item.priceCents
        }
        let newUnits = totalPriceCents / 100
        let remainderCents = totalPriceCents % 100
        totalPriceUnits += newUnits
        totalPriceCents = remainderCents
    }
    
    static func add(units: Int32, cents: Int32) {
        totalPriceCents += cents
        let newUnits = totalPriceCents / 100
        let remainderCents = totalPriceCents % 100
        totalPriceUnits += newUnits
        totalPriceCents = remainderCents
    }
    
    static func subtract(units: Int32, cents: Int32) {
        totalPriceCents -= cents
        if totalPriceCents < 0 {
            totalPriceCents = 100 + totalPriceCents
            totalPriceUnits = totalPriceUnits - 1
        }
    }
}
