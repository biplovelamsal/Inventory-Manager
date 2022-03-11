//
//  UpdateViewController.swift
//  InventoryApp
//
//  Created by Biplove lamsal on 03/08/22.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var textfieldQty: UITextField!
    var inventory:InventoryDataModel = InventoryDataModel()
    var createItemDelegate:CreateItemDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = inventory.title
    }
    

    @IBAction func onTapBtnUpdate(_ sender: Any) {
        let qty = Int(textfieldQty.text ?? "") ?? 0
        inventory.qty = qty
        createItemDelegate?.onUpdateItem(inventary: inventory)
        navigationController?.popViewController(animated: true)
    }
    
}
