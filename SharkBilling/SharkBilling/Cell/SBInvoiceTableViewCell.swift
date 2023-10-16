//
//  SBInvoiceTableViewCell.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import UIKit

class SBInvoiceTableViewCell: UITableViewCell {
    
    
    // MARK: - Properties
    
    var invoiceData: InvoiceModel?
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var invoiceIdLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    @IBOutlet weak var billAmountLbl: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: - Set up
    
    static var rowHeight: CGFloat {
        return 70
    }
    
    func config(dataModel: InvoiceModel)
    {
        invoiceData = dataModel
        invoiceIdLbl.text = "InvoiceId: \(dataModel.invoiceId ?? 0)"
        durationLbl.text = dataModel.duration?.dateToStringFormatter()
        billAmountLbl.text = "$\(dataModel.billTotal ?? 0.0)"
    }
    
    // MARK: - IBActions
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    // MARK: - Network Manager calls
    
    
    
}

// MARK: - Extensions


