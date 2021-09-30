//
//  TopicDbStorageService.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation


protocol TopicDbStorageServiceProtocol {
    func update(topic:TopicTable) -> Bool
    func getAllTopic() -> [TopicTable]
    func removeAll() -> Bool
    func getTopic(idTopic:Int) -> TopicTable?
}


class TopicDbStorageService: TopicDbStorageServiceProtocol {
   
    static public let defaultFactory = TopicDbStorageService()
    
    func update(topic:TopicTable) -> Bool {            
  
        let topicRows = RealmStorageCoreService.default.getObject(TopicTable.self,  by:"id", value:topic.id)
                    
        if let _ = topicRows {
            RealmStorageCoreService.default.update(topic)
        }else{
            RealmStorageCoreService.default.save(topic)
        }
        
       return true
    }
    
    func getTopic(idTopic:Int) -> TopicTable? {
        let topicRows = RealmStorageCoreService.default.getObject(TopicTable.self,  by:"id", value:idTopic)
        if let topic = topicRows {
            return topic
        }
        return nil
    }
    
    func getAllTopic() -> [TopicTable] {
      
        let topicRows = RealmStorageCoreService.default.getAll(TopicTable.self)
        
        var savedTopicArray:[TopicTable] = []
        for topic in topicRows {
            savedTopicArray.append(topic)
        }
        
        return savedTopicArray
    }
    
    
    func removeAll() -> Bool {
        RealmStorageCoreService.default.removeAll(TopicTable.self)
        return true
    }
    
}
