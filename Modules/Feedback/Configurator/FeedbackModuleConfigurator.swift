//
//  FeedbackModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//


import Foundation

class FeedbackModuleConfigurator:  FeedbackModuleConfiguratorProtocol {
    
    public func configure() -> Presentable?  {
        
            let viewController = FeedbackViewController();
        
            let presenter = FeedbackPresenter(view: viewController)
            let interactor = FeedbackInteractor(presenter: presenter)
            let router = FeedbackRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router       
        
            return viewController
        }
    
}
