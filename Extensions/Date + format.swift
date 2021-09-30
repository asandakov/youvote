//
//  String + Date.swift
//  Flowers
//
//  Created by Алексей on 05.01.2021.
//

import Foundation


extension Date {
   
    static func from(_ value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let newDate = dateFormatter.date(from: value) {
            return newDate
        }
        else { return nil }
    }
    
    
    // форматируем дату строку формата  "dd.MM.yyyy"
    func toDateTime(format:String = "dd.MM.yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateResult = formatter.string(from: self)
        return dateResult
    }
}
