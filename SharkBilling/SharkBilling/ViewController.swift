//
//  ViewController.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var orderArr: [InvoiceModel] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var addBarBtn: UIBarButtonItem!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDefaults()
    }
    
    
    // MARK: - Set up
    
    func loadDefaults()
    {
        self.addMockData()
        registerTableCell()
    }
    
    func registerTableCell()
    {
        self.orderTableView.register(SBInvoiceTableViewCell.nib, forCellReuseIdentifier: SBInvoiceTableViewCell.identifier)
    }
    
    func addMockData()
    {
        orderArr = MockData().invoiceModel
    }
    
    
    
    // MARK: - IBActions
    
    @IBAction func addBarBtnAction(_ sender: UIBarButtonItem) {
        navigateToBillVC(dataModel: nil)
    }
    
    // MARK: - Actions
    
    
    // MARK: - Navigation
    
    func navigateToBillVC(dataModel: InvoiceModel?)
    {
        if let billVC = self.storyboard?.instantiateViewController(withIdentifier: "SBBillsViewController") as? SBBillsViewController {
            billVC.delegate = self
            let billVM = SBBillsViewModel()
            
            if let _dataModel = dataModel {
                billVM.invoiceData = _dataModel
            }
            
            billVC.viewModel = billVM
            self.navigationController?.pushViewController(billVC, animated: true)
        }
    }
    
    // MARK: - Network Manager calls
    
    
}


// MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SBInvoiceTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SBInvoiceTableViewCell") as? SBInvoiceTableViewCell {
            cell.config(dataModel: orderArr[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToBillVC(dataModel: orderArr[indexPath.row])
    }
}

extension ViewController : SBBillsViewControllerProtocol {
    func addNewOrderToList(newOrder: InvoiceModel) {
        
        let orderIds = Set(orderArr.map {$0.invoiceId ?? 0})
        
        if !orderIds.contains(newOrder.invoiceId ?? 0) {
            orderArr.append(newOrder)
        }
        
        orderTableView.reloadData()
    }
    
}
