//
//  HeaderView.swift
//  InventoryApp
//
//  Created by Biplove lamsal on 03/08/22.
//

import Foundation
import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblHeaderTitle.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
}
