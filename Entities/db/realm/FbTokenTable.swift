//
//  FbTokenTable.swift
//  YouVote
//
//  Created by Алексей on 27.09.2021.
//

import Foundation
import RealmSwift
 
class FbTokenTable: Object {
    @objc dynamic var id = 0
    @objc dynamic var token = ""
    @objc dynamic var currentDate = Date()
    
  override static func primaryKey() -> String? {
           return "id"
  }
}
