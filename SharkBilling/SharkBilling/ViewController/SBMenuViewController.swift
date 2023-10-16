//
//  SBMenuViewController.swift
//  SharkBilling
//
//  Created by Vijay on 15/10/23.
//

import UIKit

protocol SBMenuViewControllerProtocol: AnyObject {
    func selectedMenus(menu: [MenuItem])
}

class SBMenuViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: SBMenuViewModel?
    weak var delegate: SBMenuViewControllerProtocol?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaults()
    }
    
    
    // MARK: - Set up
    
    func loadDefaults()
    {
        registerTableCell()
    }
    
    func registerTableCell()
    {
        self.menuTableView.register(SBItemTableViewCell.nib, forCellReuseIdentifier: SBItemTableViewCell.identifier)
    }
    
    
    deinit {
        print("SBMenuViewController deinited")
    }
    
    // MARK: - IBActions
    
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        
        //        let temp1 = viewModel?.menuItemsArr
        let zeroCountRemoved = viewModel?.menuItemsArr.filter({ tempMenuItem in
            
            guard let tempCount = tempMenuItem.itemCount else { return false }
            if tempCount.count ?? 0 > 0 || tempCount.isChanged ?? false {
                tempCount.isChanged = false
                return true
            }
            return false
        })
        //        let temp2 = zeroCountRemoved
        
        delegate?.selectedMenus(menu: zeroCountRemoved ?? [])
        
        self.dismiss(animated: true)
    }
    
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    // MARK: - Network Manager calls
}


// MARK: - Extensions


extension SBMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SBItemTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.menuItemsArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SBItemTableViewCell") as? SBItemTableViewCell {
            
            if let tempMenuItem = viewModel?.menuItemsArr[indexPath.row] {
                cell.isFromMenu = true
                cell.delegate = self
                cell.configCell(menuItemValue: tempMenuItem)
                cell.selectedIndexPath = indexPath
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension SBMenuViewController: SBItemTableViewCellProtocol {
    func removeDeletedItem(selectedIndexPath: IndexPath) {
        viewModel?.menuItemsArr.remove(at: selectedIndexPath.row)
        menuTableView.reloadData()
    }
    
}
