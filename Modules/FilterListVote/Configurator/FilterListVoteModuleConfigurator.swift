//
//  FilterListVoteModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//


import Foundation

class FilterListVoteModuleConfigurator:  FilterListVoteModuleConfiguratorProtocol {
    
    public func configure() -> Presentable?  {
        
            let viewController = FilterListVoteViewController();
        
            let presenter = FilterListVotePresenter(view: viewController)
            let interactor = FilterListVoteInteractor(presenter: presenter)
            let router = FilterListVoteRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router       
        
            return viewController
        }
    
}
