//
//  computeTotal.swift
//  ShoppingList
//
//  Created by Paolo on 10/01/21.
//

import Foundation
import Combine

final class ComputeTotal: ObservableObject {
    @Published var totalPriceUnits: Int32 = 0
    @Published var totalPriceCents: Int32 = 0
    @Published var totalItemPrice: String = "0,00"
    
    func update_totals(items: [ShoppingItem]) {
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
        updateString()
    }
    
    func add(units: Int32, cents: Int32) {
        totalPriceCents += cents
        let newUnits = totalPriceCents / 100
        let remainderCents = totalPriceCents % 100
        totalPriceUnits += (units + newUnits)
        totalPriceCents = remainderCents
        updateString()
    }
    
    func subtract(units: Int32, cents: Int32) {
        totalPriceCents -= cents
        totalPriceUnits -= units
        if totalPriceCents < 0 {
            totalPriceCents = 100 + totalPriceCents
            totalPriceUnits = totalPriceUnits - 1
        }
        updateString()
    }
    
    func updateString() {
        totalItemPrice = "\(totalPriceUnits),\(totalPriceCents)"
    }
}
