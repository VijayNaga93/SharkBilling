//
//  SBCloseOrderSUIModel.swift
//  SharkBilling
//
//  Created by Vijay on 16/10/23.
//

import Foundation
import SwiftUI

class SBCloseOrderSUIModel: ObservableObject {
    
    @Published var invoiceDataModel: InvoiceModel
    
    init(invoiceDataModel: InvoiceModel) {
        self.invoiceDataModel = invoiceDataModel
    }
    
    
    
}
