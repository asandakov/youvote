//
//  FeedbackRouter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class FeedbackRouter: FeedbackRouterProtocol {
    weak var view: FeedbackViewController?
    
    init(viewController: FeedbackViewController) {
         self.view = viewController
    }
    
}
