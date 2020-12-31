//
//  ShoppingItemTableViewController.swift
//  Shopping List
//
//  Created by Paolo on 30/12/20.
//

import UIKit

class ShoppingItemTableViewController: UITableViewController {

    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var shoppingItems = [ShoppingItem]()
    var totalQuantity: Int = 0
    var totalPriceUnits: Int = 0
    var totalPriceCents: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        
        loadSampleItems()
        updateTotals()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItemCell", for: indexPath) as? ShoppingItemTableViewCell else {
            fatalError("Cell is not instance of ShoppingItemCell")
        }
        let shoppingItem = shoppingItems[indexPath.row]

        cell.itemNameLabel.text = shoppingItem.name
        cell.priceLabel.text = "R$\(shoppingItem.priceUnit),\(shoppingItem.priceCents)"
        cell.quantityLabel.text = String(shoppingItem.quantity)
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            shoppingItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateTotals()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ShoppingItemViewController {
            
            let shoppingItem = sourceViewController.shoppingItem
            
            let newIndexPath = IndexPath(row: shoppingItems.count, section: 0)

            shoppingItems.append(shoppingItem)
            tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.right)
            updateTotals()
        }
    }
    
    // MARK: Private Methods
    
    func loadSampleItems() {
        let item1 = ShoppingItem(name: "Example", priceUnit: 2, priceCents: 51, quantity: 3, brand: "Br4nd")
        let item2 = ShoppingItem(name: "Another item", priceUnit: 23, priceCents: 0, quantity: 5, brand: "Br4nd")
        let item3 = ShoppingItem(name: "A Longer Item Name", priceUnit: 92, priceCents: 99, quantity: 1, brand: "Br4nd")
        shoppingItems += [item1, item2, item3]
        shoppingItems += [item1, item2, item3]
        shoppingItems += [item1, item2, item3]
        shoppingItems += [item1, item2, item3]
        shoppingItems += [item1, item2, item3]
        shoppingItems += [item1, item2, item3]
    }

    func updateTotals() {
        calculateTotalValues()
        updateTotalLabels()

    }

    func calculateTotalValues() {
        var unitTotal = 0
        var centsTotal = 0
        var quantityTotal = 0
        for item in shoppingItems {
            unitTotal += item.priceUnit
            centsTotal += item.priceCents
            quantityTotal += item.quantity
        }
        if centsTotal >= 100 {
            let newUnits = centsTotal / 100
            let centsRemainder = centsTotal % 100
            unitTotal += newUnits
            centsTotal = centsRemainder
        }
        self.totalQuantity = quantityTotal
        self.totalPriceUnits = unitTotal
        self.totalPriceCents = centsTotal
    }
    
    func updateTotalLabels() {
        totalPriceLabel.text = "R$\(self.totalPriceUnits),\(self.totalPriceCents)"
        totalQuantityLabel.text = String(self.totalQuantity)
    }
}
