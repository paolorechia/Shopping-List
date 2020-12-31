//
//  ShoppingItemViewController.swift
//  Shopping List
//
//  Created by Paolo on 30/12/20.
//

import UIKit

class ShoppingItemViewController:
    UIViewController, UITextFieldDelegate {
    // MARK: Properties
    var shoppingItem = ShoppingItem(name: "", priceUnit: 0, priceCents: 0, quantity: 1, brand: "")

    // MARK: Outlets
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var priceUnitField: UITextField!
    @IBOutlet weak var priceCentsField: UITextField!
    @IBOutlet weak var quantityField: UILabel!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    // MARK: Actions

    // MARK: EditingDidBegin
    @IBAction func itemNameEditingDidBegin(_ sender: Any) {
        disableSave()
    }
    @IBAction func priceUnitEditingDidBegin(_ sender: Any) {
        disableSave()
    }
    @IBAction func priceCentsEditingDidBegin(_ sender: Any) {
        disableSave()
    }
    @IBAction func brandEditingDidBegin(_ sender: Any) {
        disableSave()
    }
    // MARK: EditingDidEnd
    @IBAction func itemNameEditingDidEnd(_ sender: UITextField) {
        print("Edited name")
        shoppingItem.name = sender.text ?? ""
        enableSave()

    }
    @IBAction func priceUnitEditingDidEnd(_ sender: UITextField) {
        print("Edited price Unit")
        shoppingItem.priceUnit = Int(String(sender.text ?? "0")) ?? 0
        enableSave()
    }
    @IBAction func priceCentsEditingDidEnd(_ sender: UITextField) {
        shoppingItem.priceCents = Int(String(sender.text ?? "0")) ?? 0
        enableSave()
    }
    @IBAction func touchUpPlusAction(_ sender: Any) {
        print("Pressed plus")
        shoppingItem.quantity += 1
        quantityField.text = String(shoppingItem.quantity)
    }
    
    @IBAction func touchUpMinusAction(_ sender: Any) {
        print("Pressed minus")
        if (shoppingItem.quantity > 1) {
            shoppingItem.quantity = shoppingItem.quantity - 1
            quantityField.text = String(shoppingItem.quantity)

        }
    }
    @IBAction func brandEditingDidEnd(_ sender: UITextField) {
        print("Edited brand")
        shoppingItem.brand = sender.text ?? ""
        enableSave()
    }
    
    // MARK: TouchUp Actions
    @IBAction func touchUpCancelButton(_ sender: Any) {
        print("Cancel button pressed")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func touchUpSaveButton(_ sender: Any) {
        print("Save button pressed")
        print(shoppingItem)
        print("Name: ", shoppingItem.name, "; Brand: ", shoppingItem.brand,
            "PriceUnit:", shoppingItem.priceUnit,
              "PriceCents:", shoppingItem.priceCents,
              "Quantity:", shoppingItem.quantity)
    }

    
    // MARK: Default properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        disableSave()
        itemNameField.delegate = self
        priceUnitField.delegate = self
        priceCentsField.delegate = self
        brandField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: Private Methods
    
    func disableSave() {
        saveButton.isEnabled = false
    }
    
    func shouldSaveBeEnabled() -> Bool {
        return ((!shoppingItem.name.isEmpty) && (shoppingItem.priceUnit > 0 || shoppingItem.priceCents > 0))
    }
    func enableSave() {
        if shouldSaveBeEnabled() {
            print("Enabled save.")
            saveButton.isEnabled = true
            
        }
    }
}
