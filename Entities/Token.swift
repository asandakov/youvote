//
//  Token.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

class Token:Codable {
    var access:String = ""
    var refresh:String = ""
    var timeAssess = 0
    var currentDate = Date()
    
    enum CodingKeys:String, CodingKey {
        case access = "ACCESS_TOKEN"
        case refresh = "REFRESH_TOKEN"
        case timeAssess = "TIME_ACCESS_TOKEN"
    }
}
