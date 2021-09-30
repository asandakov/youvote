//
//  String+Currency.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation

extension String {
    
    var stingWithCurrency: String {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        guard
            let number = formatter.number(from: self),
            let numberString = formatter.string(from: number)
            else {
                return String(format: "%@", "₽")
        }
      
        return String(format: "%@ %@", numberString, "₽")
    }
        
}
