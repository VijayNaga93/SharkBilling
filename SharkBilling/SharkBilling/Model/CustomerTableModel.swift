//
//  CustomerTableModel.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import Foundation

class CustomerTable {
    var id: Int?
    var peopleCount: Int?
    var items: [MenuItem]?
    
    init(id: Int? = nil, peopleCount: Int? = nil, items: [MenuItem]? = nil) {
        self.id = id
        self.peopleCount = peopleCount
        self.items = items
    }
}
