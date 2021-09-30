//
//  TokenModel.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//


import Foundation
import RealmSwift
 
class TokenTable: Object {
    @objc dynamic var id = 0
    @objc dynamic var access = ""
    @objc dynamic var refresh = ""
    @objc dynamic var timeAssess = 0
    @objc dynamic var currentDate = Date()
    
  override static func primaryKey() -> String? {
           return "id"
  }
}


