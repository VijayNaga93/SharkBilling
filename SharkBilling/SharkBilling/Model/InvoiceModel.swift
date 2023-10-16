//
//  InvoiceModel.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import Foundation

class InvoiceModel {
    var invoiceId: Int?
    var gstNo: String?
    var customerTable: CustomerTable?
    var duration: Date?
    var tax: Float?
    var discount: Float?
    var paymentMethod: PaymentMethod?
    var billTotal: Float?
    var split: BillSplit?
    var balance: PaymentBalance?
    
    init(invoiceId: Int? = nil, gstNo: String? = nil, customerTable: CustomerTable? = nil, duration: Date? = nil, tax: Float? = nil, discount: Float? = nil, paymentMethod: PaymentMethod? = nil, billTotal: Float? = nil, split: BillSplit? = nil, balance: PaymentBalance? = nil) {
        self.invoiceId = invoiceId
        self.gstNo = gstNo
        self.customerTable = customerTable
        self.duration = duration
        self.tax = tax
        self.discount = discount
        self.paymentMethod = paymentMethod
        self.billTotal = billTotal
        self.split = split
        self.balance = balance
    }
}

enum PaymentMethod {
    case cash
    case debitCard
    case creditCard
}

class BillSplit {
    
    var noOfPeople: Int?
    var perShare: Float?
    
    init(noOfPeople: Int? = nil, perShare: Float? = nil) {
        self.noOfPeople = noOfPeople
        self.perShare = perShare
    }
}

class PaymentBalance {
    var paid: CGFloat?
    var returned: CGFloat?
    var remaining: CGFloat?
    
    init(paid: CGFloat? = nil, returned: CGFloat? = nil, remaining: CGFloat? = nil) {
        self.paid = paid
        self.returned = returned
        self.remaining = remaining
    }
}
