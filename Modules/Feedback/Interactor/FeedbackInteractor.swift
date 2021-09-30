//
//  FeedbackInteractor.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class FeedbackInteractor: FeedbackInteractorProtocol {
    weak var presenter: FeedbackInteractorPresenterProtocol!
    
    
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    
    required init(presenter:  FeedbackInteractorPresenterProtocol) {
        self.presenter = presenter

    }
    
    
    func sendFeedback(name:String, email:String, text:String) {
      
        let params = [
            "name": name,
            "email": email,
            "text": text
        ]
        
        presenter.startProgress()
      
        factoryNetwork.getFeedbackNetworkService().sendFeedback(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.presenter.endProgress()
               
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let sendFeedbackResponce = try? decoder.decode(SendFeedbackResponce.self, from: jsonData)
                                    else {
                                  
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                         
                                      return
                                   }
                            
                            
                            self.presenter.answerSendFeedback(send: sendFeedbackResponce.send)
                           
                         
                          
                        case  .failure(let error):
                            
                            
                            let (error,_)  = error.errorDescription
                            
                            if let errorMsg = error{
                                
                                self.presenter.showAlert(message: errorMsg)
                          
                            
                            }
                            
                    }
                

            }
    }
}
