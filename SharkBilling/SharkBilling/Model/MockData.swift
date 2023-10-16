//
//  MockData.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import Foundation

let staticTax: Float = 5.0
let staticCreditCardCharge: Float = 1.2
let staticGstNo: String = "GSTIN:11VJZPA8802E1Z8"
let staticCurrentType: String = "$"

class MockData {
    
    
    var invoiceModel : [InvoiceModel] = [
        InvoiceModel(invoiceId: 1, gstNo: staticGstNo,
                     customerTable: CustomerTable(id: 1, peopleCount: 3, items: [
                        MenuItem(menuId: "SB101", name: "Big Brekkie", price: 16, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB101", name: "Big Brekkie", price: 16, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB102", name: "Bruchetta", price: 8, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB103", name: "Poached Eggs", price: 12, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB104", name: "Coffee", price: 5, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB105", name: "Tea", price: 3, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB106", name: "Soda", price: 4, itemCount: MenuItemCount(count: 1)),
                     ]),
                     duration: Date(), tax: staticTax, discount: nil, paymentMethod: .cash, billTotal: 64),
        
        InvoiceModel(invoiceId: 2, gstNo: staticGstNo,
                     customerTable: CustomerTable(id: 2, peopleCount: 5, items: [
                        MenuItem(menuId: "SB105", name: "Tea", price: 3, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB104", name: "Coffee", price: 3, itemCount: MenuItemCount(count: 3)),
                        MenuItem(menuId: "SB106", name: "Soda", price: 4, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB101", name: "Big Brekkie", price: 16, itemCount: MenuItemCount(count: 3)),
                        MenuItem(menuId: "SB103", name: "Poached Eggs", price: 12, itemCount: MenuItemCount(count: 1)),
                        MenuItem(menuId: "SB107", name: "Garden Salad", price: 10, itemCount: MenuItemCount(count: 1)),
                     ]),
                     duration: Date(), tax: staticTax, discount: nil, paymentMethod: .creditCard, billTotal: 84.97),
        
        InvoiceModel(invoiceId: 3, gstNo: staticGstNo,
                     customerTable: CustomerTable(id: 3, peopleCount: 7, items: [
                        MenuItem(menuId: "SB105", name: "Tea", price: 3, itemCount: MenuItemCount(count: 2)),
                        MenuItem(menuId: "SB104", name: "Coffee", price: 3, itemCount: MenuItemCount(count: 3)),
                        MenuItem(menuId: "SB106", name: "Soda", price: 4, itemCount: MenuItemCount(count: 2)),
                        MenuItem(menuId: "SB102", name: "Bruchetta", price: 8, itemCount: MenuItemCount(count: 5)),
                        MenuItem(menuId: "SB101", name: "Big Brekkie", price: 16, itemCount: MenuItemCount(count: 5)),
                        MenuItem(menuId: "SB103", name: "Poached Eggs", price: 12, itemCount: MenuItemCount(count: 2)),
                        MenuItem(menuId: "SB107", name: "Garden Salad", price: 10, itemCount: MenuItemCount(count: 3)),
                     ]),
                     duration: Date(), tax: staticTax, discount: 25.0, paymentMethod: .cash, billTotal: 172)
    ]
    
    
    var menuItemData: [MenuItem] = [
        MenuItem(menuId: "SB101", name: "Big Brekkie", price: 16, itemCount: nil),
        MenuItem(menuId: "SB102", name: "Bruchetta", price: 8, itemCount: nil),
        MenuItem(menuId: "SB103", name: "Poached Eggs", price: 12, itemCount: nil),
        MenuItem(menuId: "SB104", name: "Coffee", price: 3, itemCount: nil),
        MenuItem(menuId: "SB105", name: "Tea", price: 3, itemCount: nil),
        MenuItem(menuId: "SB106", name: "Soda", price: 4, itemCount: nil),
        MenuItem(menuId: "SB107", name: "Garden Salad", price: 10, itemCount: nil),
    ]
    
}
