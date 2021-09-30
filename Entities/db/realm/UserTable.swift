//
//  UserTable.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

import RealmSwift
 
class UserTable: Object {
    @objc dynamic var id = 0
    @objc dynamic var fio = ""
    @objc dynamic var login = Localization.Profil.emailNameParam
    @objc dynamic var currentDate = Date()
    
  override static func primaryKey() -> String? {
           return "id"
  }
}
