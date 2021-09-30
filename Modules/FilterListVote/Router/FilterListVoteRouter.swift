//
//  FilterListVoteRouter.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import UIKit

class FilterListVoteRouter: FilterListVoteRouterProtocol {
    weak var view: FilterListVoteViewController?
    
    init(viewController: FilterListVoteViewController) {
         self.view = viewController
    }
    
}
