//
//  DetailVoteInteractor.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class DetailVoteInteractor: DetailVoteInteractorProtocol {
 
    weak var presenter: DetailVoteInteractorPresenterProtocol!
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    
    
    required init(presenter:  DetailVoteInteractorPresenterProtocol) {
        self.presenter = presenter
    }
    
  
    
    func getVote(idVote:Int = 0) -> () {
      
        let params = [
            "idVote": String(idVote)    
        ]
        self.presenter.startProgress()
        factoryNetwork.getVoteNetworkService().getVote(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
                
                   self.presenter.endProgress()                   
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                       
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let voteDeatailResponce = try? decoder.decode(VoteDeatailResponce.self, from: jsonData)
                                    else {
                                    
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                             
                                      return
                                   }
                         
                            guard
                                let vote = voteDeatailResponce.vote
                                else {
                                    self.presenter.showAlert(message: Localization.DetailVote.errorNoVote)
                                      return
                               }
                            
                      
                         self.presenter.answerVote(vote: vote)
                                           
                        case  .failure(let error):
                           
                            let (error,_) = error.errorDescription
                                                                    
                            if let errorMsg = error{
                                self.presenter.showAlert(message: errorMsg)
                            }
                            
                    }                

            }
        
    }
    
    
    
    func pollVote(idVote:Int = 0, idVariant:Int = 0) -> () {
      
        let params = [
            "idVote": String(idVote),
            "idVariant": String(idVariant)
        ]
        
        self.presenter.startProgress()
        factoryNetwork.getVoteNetworkService().pollVote(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
                
                   self.presenter.endProgress()
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                       
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let pollVoteResponce = try? decoder.decode(PollVoteResponce.self, from: jsonData)
                                    else {
                                    
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                                      return
                                   }
                         
                                                    
                      
                       self.presenter.answerPollVote(success:pollVoteResponce.success)
                            
                                           
                        case  .failure(let error):
                           
                            let (error,code) = error.errorDescription
                                 
                            
                            if  let codeMsg  = code{
                               
                                let elementsCode = ["token_access", "info_user_1"]
                                if elementsCode.contains(codeMsg) {
                                    self.presenter.showAlert(message: Localization.DetailVote.noAuth)
                                return
                                }
                               
                            }
                            
                            if let errorMsg = error{
                                self.presenter.showAlert(message: errorMsg)
                            }
                            
                    }

            }
        
    }
}
