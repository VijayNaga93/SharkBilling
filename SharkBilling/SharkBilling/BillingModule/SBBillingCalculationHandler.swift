//
//  SBBillingCalculationHandler.swift
//  SharkBilling
//
//  Created by Vijay on 16/10/23.
//

import Foundation

class SBBillingCalculationHandler: NSObject {
    
    
    class func getPriceCountTotalString(menuItemValue: MenuItem) -> String {
        
        let perMenuPrice = menuItemValue.price ?? 0.0
        let menuCount = menuItemValue.itemCount?.count
        let totalPrice = (perMenuPrice) * Double(menuCount ?? 0)
        
        
        let finalStr = "$\(perMenuPrice) * \(menuCount ?? 0) = \(totalPrice)"
        //        print("finalStr-->\(finalStr)")
        return finalStr
    }
    
    // MARK: - get invoice data as parameter and give the final total amount for the Menu
    class func finaliseTotalForSelectedMenu(invoiceDataModel: InvoiceModel) -> Float
    {
        let total = invoiceDataModel.customerTable?.items?.reduce(0.0, { partialResult, item in
            
            let price = item.price ?? 0.0
            let count = item.itemCount?.count ?? 0
            let total = price * Double(count)
            
            return partialResult + total
        })
        
        return Float(total ?? 0.0)
    }
    
    // MARK: - get multiple Invoice and prints one by one.
    class func batchTransactions(invoiceGroup: [InvoiceModel]) {
        for invoice in invoiceGroup {
            printInvoice(invoiceDataModel: invoice)
        }
    }
    
    
    // MARK: - get invoice data as parameter and print the invoice ( use this as printer text)
    class func printInvoice(invoiceDataModel: InvoiceModel) {
        
        print("SBBillingCalculationHandler \(invoiceDataModel.gstNo ?? "")")
        let invoice = invoiceDataModel

               print("Invoice ID: \(invoice.invoiceId ?? 0)")
               print("GST No: \(invoice.gstNo ?? "")")
               print("Date: \(invoice.duration ?? Date())")
               
               if let customerTable = invoice.customerTable {
                   print("Table ID: \(customerTable.id ?? 0)")
                   print("Number of People: \(customerTable.peopleCount ?? 0)")
                   
                   if let items = customerTable.items {
                       print("Items Ordered:")
                       for (index, item) in items.enumerated() {
                           print("\(index + 1). \(item.name ?? "") - $\(item.price ?? 0.0) x \(item.itemCount?.count ?? 0)")
                       }
                   }
               }
               
               if let tax = invoice.tax {
                   print("Tax: $\(tax)")
               }
               
               if let discount = invoice.discount {
                   print("Discount: $\(discount)")
               }
               
               print("Payment Method: \(invoice.paymentMethod ?? .cash)")
               
               if let billTotal = invoice.billTotal {
                   print("Total Bill: $\(billTotal)")
               }
               
               if let split = invoice.split, let noOfPeople = split.noOfPeople, let perShare = split.perShare {
                   print("Bill Split:")
                   print("Number of People: \(noOfPeople)")
                   print("Per Person Share: $\(perShare)")
               }
               
               if let balance = invoice.balance, let paid = balance.paid, let returned = balance.returned, let remaining = balance.remaining {
                   print("Payment Balance:")
                   print("Paid: $\(paid)")
                   print("Returned: $\(returned)")
                   print("Remaining: $\(remaining)")
               }
           }
    
}
