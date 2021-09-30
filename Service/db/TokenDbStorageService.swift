//
//  TokenDbStorage.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

protocol TokenDbStorageServiceProtocol {
    func update(token:TokenTable) -> Bool
    func token() -> TokenTable?
    func removeAll() -> Bool
}


class TokenDbStorageService: TokenDbStorageServiceProtocol {
   
    static public let defaultFactory = TokenDbStorageService()
    
    func update(token:TokenTable) -> Bool {
            
        let tokenRows = RealmStorageCoreService.default.getAll(TokenTable.self)
        
   
        
        if let _ = tokenRows.first {
            RealmStorageCoreService.default.update(token)
        }else{
            RealmStorageCoreService.default.save(token)
        }
        
       return true
    }
    
    func token() -> TokenTable? {
        let tokenRows = RealmStorageCoreService.default.getAll(TokenTable.self)
        
        if let firstToket = tokenRows.first {
           
            return firstToket
        }
        
        return nil
    }
    
    func removeAll() -> Bool {
        RealmStorageCoreService.default.removeAll(TokenTable.self)
        return true
    }
}
