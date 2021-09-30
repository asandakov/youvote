//
//  TopicTable.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation
import RealmSwift
 
class TopicTable: Object {
    @objc dynamic var id = 0
    @objc dynamic var code = ""
    @objc dynamic var name = ""
    @objc dynamic var level = 0
    @objc dynamic var currentDate = Date()
    
  override static func primaryKey() -> String? {
           return "id"
  }
}
