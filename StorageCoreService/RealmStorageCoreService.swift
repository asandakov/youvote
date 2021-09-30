//
//  RealmStorageCoreService.swift
//  YouVote
//
//  Created by Алексей on 21.05.2021.
//

import Foundation
import RealmSwift

protocol RealmStorageCoreServiceProtocol {
    
    //MARK: Get block
    func getAll<T : Object>(_ type : T.Type) -> Results<T>
    func getObject<T : Object>(_ object : T.Type, by uniqueKeyPath: String, value: Any) -> T?
    func getFromFilter<T : Object>(predicate: NSPredicate, type : T.Type) -> Results<T>
    
    //MARK: Save block
    func save(_ object : Object)
    func saveObject<T: Object>(_ object : T, uniqueKeyPath: String)
    func saveObjects<T: Object>( objects: [T], uniqueKeyPath: String)
    
    //MARK: Delete block
    func removeDatabase()
    func removeAll(_ type : Object.Type)
    func remove<T : Object>(_ type : T.Type, at index: Int)
    func remove(object: Object)
}

final class RealmStorageCoreService: RealmStorageCoreServiceProtocol {
    
    static public let `default` = RealmStorageCoreService()
    
    //MARK: Get block
    func getAll<T : Object>(_ type : T.Type) -> Results<T> {
        let realm = try! Realm()
        
        let allObjects = realm.objects(type)
        return allObjects
    }
    
    func getFromFilter<T : Object>(predicate: NSPredicate, type : T.Type) -> Results<T> {
        let realm = try! Realm()
        
        let allObjects = realm.objects(type).filter(predicate)
        return allObjects
    }
    
    func getObject<T : Object>(_ object : T.Type, by uniqueKeyPath: String, value: Any) -> T? {
        let realm = try! Realm()
        
        let needObject = realm.objects(T.self).filter("\(uniqueKeyPath) = %@", value).first
        return needObject
    }
   
    //MARK: Update block
    func update(_ object : Object) {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            assert(false, "Realm can't update object")
        }
    }
    
    
    //MARK: Save block
    func save(_ object : Object) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            assert(false, "Realm can't save object")
        }
    }
    
    
    func saveObject<T: Object>(_ object : T, uniqueKeyPath: String) {
        let realm = try! Realm()
        
        guard let identifier = object.value(forKey: uniqueKeyPath) else {
            assert(false, "No uniqueKeyPath for object: (\(object))")
            return
        }
        
        let realmSavedObjects = realm.objects(T.self).filter("\(uniqueKeyPath) = %@", identifier)
        
        if let realmSavedObject = realmSavedObjects.first {
            do {
                try realm.write {
                    realm.delete(realmSavedObject)
                    realm.add(object)
                }
            } catch {
                assert(false, "Realm can't save concrete object")
            }
        }
        else {
            self.save(object)
        }
    }
    
    func saveObjects<T: Object>( objects: [T], uniqueKeyPath: String) {
        for object in objects {
            self.saveObject(object, uniqueKeyPath: uniqueKeyPath)
        }
    }
    
    
    //MARK: Delete block
    func removeDatabase() {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            assert(false, "Realm can't delete database")
        }
    }
    
    func removeAll(_ type : Object.Type) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch {
            assert(false, "Realm can't delete objects")
        }
    }
    
    func remove<T : Object>(_ type : T.Type, at index: Int) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                let object = getAll(T.self)[index]
                realm.delete(object)
            }
        } catch {
            assert(false, "Realm can't delete concrete object")
        }
    }

    func remove(object: Object) {
        let realm = try! Realm()

        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            assert(false, "Realm can't delete concrete object")
        }
    }
}
