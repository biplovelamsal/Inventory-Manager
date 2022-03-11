//
//  InventoryDataModel.swift
//  InventoryApp
//
//  Created by Biplove lamsal on 03/08/22.
//

import Foundation

struct InventoryDataModel : Hashable {
    var title:String = ""
    var qty = 0
    var itemType : Section = .puzzle
}
