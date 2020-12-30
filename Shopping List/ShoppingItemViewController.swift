//
//  ShoppingItemViewController.swift
//  Shopping List
//
//  Created by Paolo on 30/12/20.
//

import UIKit

class ShoppingItemViewController:
    
    // MARK: Properties
    UIViewController {
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

    
    // MARK: Default properties
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
