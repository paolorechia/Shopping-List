//
//  ShoppingItemView.swift
//  Shopping List
//
//  Created by Paolo on 30/12/20.
//

import UIKit

class ShoppingItemView: UIView {
    @IBOutlet weak var itemNameField: UITextField!
     @IBOutlet weak var priceUnitField: UITextField!
     @IBOutlet weak var priceCentsField: UITextField!

    @IBOutlet weak var quantityField: UILabel!

    @IBAction func touchUpPlusAction(_ sender: Any) {
        print("Pressed plus")
    }
    
    @IBAction func touchUpMinusAction(_ sender: Any) {
        print("Pressed minus")
    }
    @IBOutlet var brandField: [UITextField]!

}
