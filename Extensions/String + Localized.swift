//
//  String + Localized.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation


extension String {
    func localized(tableTame:String = "Localizable") -> String{
        return NSLocalizedString(self, tableName: tableTame, value: "-\(self)-", comment: "")
    }
}
