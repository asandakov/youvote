//
//  DetailVoteRouter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class DetailVoteRouter: DetailVoteRouterProtocol {
    weak var view: DetailVoteViewController?
    
    init(viewController: DetailVoteViewController) {
         self.view = viewController
    }
    
}
