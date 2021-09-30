//
//  FilterListVoteInteractor.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

class FilterListVoteInteractor: FilterListVoteInteractorProtocol {
  
    weak var presenter: FilterListVoteInteractorPresenterProtocol!
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    let factoryDb: FactoryDbStorageServiceProtocol = FactoryDbStorageService()
    let dataUserDefaults = UserDefaults.standard
    
    required init(presenter:  FilterListVoteInteractorPresenterProtocol) {
        self.presenter = presenter

    }
    
    func getAllTopic() -> [TopicTable] {
        let allTopic = self.factoryDb.getTopicDbStorageService().getAllTopic()
        return allTopic
    }
    
    func setCurTopic(idTopic:Int) {
        dataUserDefaults.setValue(idTopic, forKey: "idTopicFilter")
    }
    
    func getCurTopic() -> TopicTable? {
        
        guard let idTopicFilter = dataUserDefaults.object(forKey: "idTopicFilter"), let idTopic =  idTopicFilter as? Int  else {
            return nil
        }
     
        if let topic = self.factoryDb.getTopicDbStorageService().getTopic(idTopic: idTopic) {
            return topic
        }
             
        dataUserDefaults.setValue("", forKey: "idTopicFilter")
        
        return nil
    }
    
  
    
    func getParamFilter(){
        
  
        self.presenter.startProgress()
        factoryNetwork.getVoteNetworkService().getParamFilter(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }
                
                   self.presenter.endProgress()
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                       
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let filterParamVoteResponce = try? decoder.decode(FilterParamVoteResponce.self, from: jsonData)
                                    else {
                                    
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                                      return
                                   }
                        
                            
                            if filterParamVoteResponce.topic.count > 0 {
                                
                                for topic in filterParamVoteResponce.topic {
                                    let topicDb = TopicTable()
                                    topicDb.id = Int(topic.id) ?? 0
                                    topicDb.code = topic.code
                                    topicDb.name = topic.name
                                    topicDb.level = Int(topic.level) ?? 0
                            
                                    let _ = self.factoryDb.getTopicDbStorageService().update(topic: topicDb)
                                }
                                
                            }
                       
                       let allTopic = self.getAllTopic()
                                        
                       self.presenter.answerFilter(topic:allTopic)
                            
                                           
                        case  .failure(let error):
                           
                            let (error,_) = error.errorDescription
                                 
                                                                               
                            if let errorMsg = error{
                                self.presenter.showAlert(message: errorMsg)
                            }
                            
                    }

            }
        
     }
    
    
}
