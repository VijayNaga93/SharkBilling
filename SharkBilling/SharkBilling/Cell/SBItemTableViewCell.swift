//
//  SBItemTableViewCell.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import UIKit

protocol SBItemTableViewCellProtocol: AnyObject {
    func removeDeletedItem(selectedIndexPath: IndexPath)
}

class SBItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isFromMenu: Bool = false
    var menuItemModel: MenuItem?
    var selectedIndexPath: IndexPath?
    
   weak var delegate: SBItemTableViewCellProtocol?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var countTxtFld: UITextField!
    
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
        return 75
    }
    
    func configCell(menuItemValue: MenuItem)
    {
        menuItemModel = menuItemValue
        deleteBtn.isHidden = isFromMenu
        updateUI()
    }
    
    func updateUI()
    {
        if let _menuItemModel = menuItemModel {
            titleLbl.text = _menuItemModel.name ?? ""
            priceLbl.text = SBBillingCalculationHandler.getPriceCountTotalString(menuItemValue: _menuItemModel)
            countTxtFld.text = "\(_menuItemModel.itemCount?.count ?? 0)"
        }
    }
    
    // MARK: - IBActions
    
    
    @IBAction func controlBtnActions(_ sender: UIButton) {
        
        let countValue: Int = Int(countTxtFld.text ?? "0") ?? 0
        
        switch sender {
        case minusBtn:
            guard countValue > 0 else {
                return
            }
            
            countTxtFld.text = "\(countValue - 1)"
            
        case plusBtn:
            countTxtFld.text = "\(countValue + 1)"
            
        case deleteBtn:
            if let _selectedIndexPath = selectedIndexPath {
                delegate?.removeDeletedItem(selectedIndexPath: _selectedIndexPath)
            }
            
        default:
            
            print("default")
        }
        
        let changedCount = Int(countTxtFld.text ?? "0") ?? 0
        menuItemModel?.itemCount = MenuItemCount(count: changedCount, isChanged: true)
        updateUI()
        
    }
    
    // MARK: - Actions
    
    func calculationControl() {
        
    }
    
    // MARK: - Navigation
    
    // MARK: - Network Manager calls
    
    
    
    
    
    
    
}


// MARK: - Extensions

