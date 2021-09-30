//
//  DetailVoteModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//


import Foundation

class DetailVoteModuleConfigurator:  DetailVoteModuleConfiguratorProtocol {
    
    public func configure(idVote:Int) -> Presentable?  {
        
            let viewController = DetailVoteViewController();
        
            let presenter = DetailVotePresenter(view: viewController, idVote:idVote)
            let interactor = DetailVoteInteractor(presenter: presenter)
            let router = DetailVoteRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router       
        
            return viewController
        }
    
}
