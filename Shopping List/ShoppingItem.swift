//
//  ShoppingItem.swift
//  Shopping List
//
//  Created by Paolo on 30/12/20.
//

import UIKit

class ShoppingItem {
    
    var name: String
    var priceUnit: Int
    var priceCents: Int
    var brand: String
    
    init(name: String, priceUnit: Int, priceCents: Int, brand: String) {
        self.name = name
        self.priceUnit = priceUnit
        self.priceCents = priceCents
        self.brand = brand
    }
}
