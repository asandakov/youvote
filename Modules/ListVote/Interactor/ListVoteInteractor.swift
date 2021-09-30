//
//  ListVoteInteractor.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class ListVoteInteractor: ListVoteInteractorProtocol {
  
    weak var presenter: ListVoteInteractorPresenterProtocol!
    
    var isPageVote = false
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    let factoryDb: FactoryDbStorageServiceProtocol = FactoryDbStorageService()
    let dataUserDefaults = UserDefaults.standard
    
    
    required init(presenter:  ListVoteInteractorPresenterProtocol) {
        self.presenter = presenter

    }
    
    
    func getCurTopic() -> TopicTable? {
        
        guard let idTopicFilter = dataUserDefaults.object(forKey: "idTopicFilter"), let idTopic =  idTopicFilter as? Int  else {
            return nil
        }
     
        if let topic = self.factoryDb.getTopicDbStorageService().getTopic(idTopic: idTopic) {
            return topic
        }
              
        return nil
    }
    
    
    func getVote(page:Int = 1, isPage:Bool = false, filter:[String:String] = [:], search:String = "") -> () {
      
        if page == 1{
            presenter.startProgress()
        }

        self.isPageVote = isPage
        
        var filter = filter
        if let topic = self.getCurTopic() {
            filter["idTopic"] =  String(topic.id)
        }
                  
        let params = [
            "page": String(page),
            "filter": filter.queryString,
            "search": search
        ]
        
        factoryNetwork.getVoteNetworkService().getList(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
                
                   if params["page"] != "1" && !self.isPageVote {
                        return
                   }
            
            
                    if page == 1 {
                        self.presenter.endProgress()
                    }
                   
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let voteResponce = try? decoder.decode(VoteResponce.self, from: jsonData)
                                    else {
                                    
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                             
                                      return
                                   }
                                       
                         self.presenter.answerVote(voteData: voteResponce)
                                           
                        case  .failure(let error):
                           
                            let (error,_) = error.errorDescription
                                                                    
                            if let errorMsg = error{
                                self.presenter.showAlert(message: errorMsg)
                            }
                            
                           
                            
                    }
                

            }
        
    }
    
}
