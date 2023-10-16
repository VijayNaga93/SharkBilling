//
//  SBBillsViewModel.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import Foundation

class SBBillsViewModel: NSObject {
    
    var invoiceData: InvoiceModel?
    
    
    // MARK: - Creating new table order invoice
    func createNewInvoiceModel()
    {
        let invoiceIdRandom = Int(arc4random_uniform(100))
        let customerTableRandom = Int(arc4random_uniform(25))
        let peopleCountRandom = Int(arc4random_uniform(10))
        
        let newCustomerTable = CustomerTable(id: customerTableRandom, peopleCount: peopleCountRandom, items: [])
        let newInvoiceModel = InvoiceModel(invoiceId: invoiceIdRandom, gstNo: staticGstNo,
                                           customerTable: newCustomerTable,
                                           duration: Date(), tax: staticTax, discount: nil, paymentMethod: nil, billTotal: nil, split: nil, balance: nil)
        
        
        invoiceData = newInvoiceModel
    }
    
    // MARK: - finalise the total after each update in the menu count
    func finaliseTotal()
    {
        if let _invoiceData = invoiceData {
            let billAmount = SBBillingCalculationHandler.finaliseTotalForSelectedMenu(invoiceDataModel: _invoiceData)
            _invoiceData.billTotal = billAmount
        }
        
//        let total = invoiceData?.customerTable?.items?.reduce(0.0, { partialResult, item in
//
//            let price = item.price ?? 0.0
//            let count = item.itemCount?.count ?? 0
//            let total = price * Double(count)
//
//            return partialResult + total
//        })
//        invoiceData?.billTotal = Float(total ?? 0.0)
    }
    
    // MARK: - creating menu items model
    func createMenuItemsModel() -> SBMenuViewModel
    {
        let menuVM = SBMenuViewModel()
        
        if let orderedItems = invoiceData?.customerTable?.items, orderedItems.count == 0
        {
            menuVM.menuItemsArr = MockData().menuItemData
        } else {
            let mergedArr = MockData().menuItemData.filter { value1 in
                let menuId1 = value1.menuId ?? ""
                
                let _ = invoiceData?.customerTable?.items?.filter({ value2 in
                    let menuId2 = value2.menuId ?? ""
                    
                    if menuId1 == menuId2 {
                        value1.itemCount = value2.itemCount
                    }
                    return true
                })
                return true
            }
            
            menuVM.menuItemsArr = mergedArr
        }
        return menuVM
    }
    
    // MARK: - Updating the selected menus with the current menu
    func formatSelectedMenus(menu: [MenuItem]) {
        
        var newAddedMenu: [MenuItem] = []
        
        var previousOrderIds = Set<String>()
        if let items = invoiceData?.customerTable?.items {
            let tempSetIds = Set(items.compactMap { $0.menuId })
            previousOrderIds = tempSetIds
        }
        
        var mergedArr = invoiceData?.customerTable?.items?.filter({ value1 in
            
            let menuId1 = value1.menuId ?? ""
            
            let _ = menu.filter { value2 in
                let menuId2 = value2.menuId ?? ""
                
                if menuId1 == menuId2 {
                    value1.itemCount = value2.itemCount
                    return true
                } else {
                    if !previousOrderIds.contains(value2.menuId ?? "") {
                        previousOrderIds.insert(value2.menuId ?? "")
                        newAddedMenu.append(value2)
                    }
                }
                return true
            }
            return true
        })
        
        if let previousOrder = invoiceData?.customerTable?.items, previousOrder.count == 0 {
            newAddedMenu.append(contentsOf: menu)
        }
        
        mergedArr?.append(contentsOf: newAddedMenu)
        newAddedMenu = []
        invoiceData?.customerTable?.items = mergedArr
        
    }
    
}
