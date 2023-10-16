//
//  MenuItemModel.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import Foundation

class MenuItem {
    var menuId: String?
    var name: String?
    var price: Double?
    var itemCount: MenuItemCount?
    
    init(menuId: String? = nil, name: String? = nil, price: Double? = nil, itemCount: MenuItemCount? = nil) {
        self.menuId = menuId
        self.name = name
        self.price = price
        self.itemCount = itemCount
    }
}

class MenuItemCount {
    var count: Int?
    var isChanged: Bool?
    
    init(count: Int? = nil, isChanged: Bool? = nil) {
        self.count = count
        self.isChanged = isChanged
    }
}


