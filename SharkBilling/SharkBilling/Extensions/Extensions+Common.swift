//
//  Extensions+Common.swift
//  SharkBilling
//
//  Created by Vijay on 15/10/23.
//

import Foundation

extension Date {
    func dateToStringFormatter() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let currentDateTime = self
        let formattedDateTime = dateFormatter.string(from: currentDateTime)
        return formattedDateTime
    }
}
