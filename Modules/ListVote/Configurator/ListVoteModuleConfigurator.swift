//
//  ListVoteModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//


import Foundation

class ListVoteModuleConfigurator:  ListVoteModuleConfiguratorProtocol {
    
    public func configure() -> Presentable?  {
        
            let viewController = ListVoteViewController();
        
            let presenter = ListVotePresenter(view: viewController)
            let interactor = ListVoteInteractor(presenter: presenter)
            let router = ListVoteRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router       
        
            return viewController
        }
    
}
