//
//  FbTokenDbStorageService.swift
//  YouVote
//
//  Created by Алексей on 27.09.2021.
//

import Foundation


protocol FbTokenDbStorageServiceProtocol {
    func update(token:FbTokenTable) -> Bool
    func token() -> FbTokenTable?
    func removeAll() -> Bool
}


class FbTokenDbStorageService: FbTokenDbStorageServiceProtocol {
   
    static public let defaultFactory = FbTokenDbStorageService()
    
    func update(token:FbTokenTable) -> Bool {
            
        let tokenRows = RealmStorageCoreService.default.getAll(FbTokenTable.self)
          
        
        if let _ = tokenRows.first {
            RealmStorageCoreService.default.update(token)
        }else{
            RealmStorageCoreService.default.save(token)
        }
        
       return true
    }
    
    func token() -> FbTokenTable? {
        let tokenRows = RealmStorageCoreService.default.getAll(FbTokenTable.self)
        
        if let firstToket = tokenRows.first {
           
            return firstToket
        }
        
        return nil
    }
    
    func removeAll() -> Bool {
        RealmStorageCoreService.default.removeAll(FbTokenTable.self)
        return true
    }
}
