//
//  ListVoteRouter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class ListVoteRouter: ListVoteRouterProtocol {
    weak var view: ListVoteViewController?
    
    init(viewController: ListVoteViewController) {
         self.view = viewController
    }
    
    func showDetailVoteScene(idVote:Int){
    
        let DetailVoteConfigurator = DetailVoteModuleConfigurator()
        guard let moduleDetailVote = DetailVoteConfigurator.configure(idVote: idVote) else {return}
        guard let DetailVoteViewController = moduleDetailVote.toPresent() else { return}
        DetailVoteViewController.hidesBottomBarWhenPushed = true
        guard let navigationController = self.view?.navigationController else { return}
        navigationController.pushViewController(DetailVoteViewController, animated: true)
     }
    
    func showFilterListVoteScene() -> Bool {
        let FilterListVoteConfigurator = FilterListVoteModuleConfigurator()
        guard let moduleFilterListVote = FilterListVoteConfigurator.configure() else {return false}
        guard let FilterListVoteViewController = moduleFilterListVote.toPresent() else { return false}
        FilterListVoteViewController.hidesBottomBarWhenPushed = true
        guard let navigationController = self.view?.navigationController else { return false}
        navigationController.pushViewController(FilterListVoteViewController, animated: true)

        return true
    }
}
