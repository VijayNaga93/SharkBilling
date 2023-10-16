//
//  Extension+TableCell.swift
//  SharkBilling
//
//  Created by Vijay on 14/10/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    var cellReuseIdentifier : String
    {
        return NSStringFromClass(type(of: type(of: self).init()) as AnyClass).components(separatedBy: ".").last!
    }
    
    static var identifier: String
    {
        return String(describing: self)
    }
    
    static var nib: UINib
    {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
