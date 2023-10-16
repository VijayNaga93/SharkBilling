//
//  SBBillsViewController.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import UIKit
import SwiftUI

protocol SBBillsViewControllerProtocol: AnyObject {
    func addNewOrderToList(newOrder: InvoiceModel)
}

class SBBillsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: SBBillsViewModel?
    weak var delegate: SBBillsViewControllerProtocol?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var billTableView: UITableView!
    
//    @IBOutlet weak var printBillBtn: UIButton!
    @IBOutlet weak var closeOrderBtn: UIButton!
//    @IBOutlet weak var sendToQueueBtn: UIButton!
    
    @IBOutlet weak var addBarBtn: UIBarButtonItem!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (viewModel?.invoiceData) == nil {
            viewModel?.createNewInvoiceModel()
            self.presentMenuViewController()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.finaliseTotal()
        checkItemsAdded()
    }
    
    deinit {
        print("SBBillsViewController deinited")
    }
    
    // MARK: - Set up
    
    
    func checkItemsAdded()
    {
        if let items = viewModel?.invoiceData?.customerTable?.items, !items.isEmpty, let newInvoiceData = viewModel?.invoiceData {
            delegate?.addNewOrderToList(newOrder: newInvoiceData)
        }
    }
    
    func loadDefaults()
    {
        registerTableCell()
    }
    
    func registerTableCell()
    {
        self.billTableView.register(SBItemTableViewCell.nib, forCellReuseIdentifier: SBItemTableViewCell.identifier)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func orderBtnActions(_ sender: UIButton) {
        
        switch sender {
        case closeOrderBtn:
            print("closeOrderBtn")
            viewModel?.finaliseTotal()
            if let _invoiceData = viewModel?.invoiceData {
                let closeOrderVM = SBCloseOrderSUIModel(invoiceDataModel: _invoiceData)
                let closeOrderSUI = UIHostingController(rootView: SBCloseOrderSUI(viewModel: closeOrderVM))
                self.present(closeOrderSUI, animated: true)
            }            
        default:
            print("default")
        }
        
        
    }
    
    @IBAction func addBarBtnAction(_ sender: UIBarButtonItem) {
        self.presentMenuViewController()
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Navigation
    
    func presentMenuViewController()
    {
        if let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "SBMenuViewController") as? SBMenuViewController {
            menuVC.delegate = self
            
            menuVC.viewModel = viewModel?.createMenuItemsModel()
            self.present(menuVC, animated: true)
        }
    }
    
    
    // MARK: - Network Manager calls
    
    
}


// MARK: - Extensions

extension SBBillsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SBItemTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.invoiceData?.customerTable?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SBItemTableViewCell") as? SBItemTableViewCell {
            
            if let tempMenuItem = viewModel?.invoiceData?.customerTable?.items?[indexPath.row] {
                cell.delegate = self
                cell.configCell(menuItemValue: tempMenuItem)
                cell.selectedIndexPath = indexPath
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension SBBillsViewController: SBItemTableViewCellProtocol {
    func removeDeletedItem(selectedIndexPath: IndexPath) {
        viewModel?.invoiceData?.customerTable?.items?.remove(at: selectedIndexPath.row)
        billTableView.reloadData()
    }
    
}


extension SBBillsViewController: SBMenuViewControllerProtocol {
    
    func selectedMenus(menu: [MenuItem]) {
        viewModel?.formatSelectedMenus(menu: menu)
        billTableView.reloadData()
    }
    
}
