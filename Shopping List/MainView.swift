//
//  ViewController.swift
//  Shopping List
//
//  Created by Paolo on 29/12/20.
//

import UIKit

class MainView: UIViewController {

    @IBOutlet weak var newShoppingButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
        // Do any additional setup after loading the view.
    }

    func styleButtons() {
        createBorder(button: historyButton)
        createBorder(button: newShoppingButton)
    }

    func createBorder(button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 5
    }

}

