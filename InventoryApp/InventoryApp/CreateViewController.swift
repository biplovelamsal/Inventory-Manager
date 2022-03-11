//
//  CreateViewController.swift
//  InventoryApp
//
//  Created by Biplove lamsal on 03/08/22.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldQty: UITextField!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    var createItemDelegate:CreateItemDelegate? = nil
    var inventary = InventoryDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapBtnAdd(_ sender: Any) {
        inventary.title = textfieldName.text ?? ""
        inventary.qty = Int(textfieldQty.text ?? "") ?? 0
        createItemDelegate?.onCreateItem(inventary: inventary)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            inventary.itemType = .puzzle
        case 1:
            inventary.itemType = .science
        case 2:
            inventary.itemType = .figure
        default:
            print("Default")
        }
    }
    
}
