//
//  UserDbStorageService.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

protocol UserDbStorageServiceProtocol {
    func update(user:UserTable) -> Bool
    func user() -> UserTable?
    func removeAll() -> Bool
}


class UserDbStorageService: UserDbStorageServiceProtocol {
   
    static public let defaultFactory = UserDbStorageService()
    
    func update(user:UserTable) -> Bool {
            
        let userRows = RealmStorageCoreService.default.getAll(UserTable.self)
                    
        if let _ = userRows.first {
            RealmStorageCoreService.default.update(user)
        }else{
            RealmStorageCoreService.default.save(user)
        }
        
       return true
    }
    
    func user() -> UserTable? {
        let userRows = RealmStorageCoreService.default.getAll(UserTable.self)
        
        if let firstUser = userRows.first {
             return firstUser
        }
        
        return nil
    }
    
    
    func removeAll() -> Bool {
        RealmStorageCoreService.default.removeAll(UserTable.self)
        return true
    }
    
}
