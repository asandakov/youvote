//
//  Images.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import UIKit

struct Images {

    struct App {
        static let logo = UIImage(named: "logo")
        static let Checked = UIImage(systemName: "smallcircle.fill.circle")
        static let notChecked = UIImage(systemName:"circle")
        static let telegram = UIImage(systemName:"paperplane.fill")
        static let inst = UIImage(systemName:"play.rectangle.fill")
    }
    
    struct Splash {
        static let logo = App.logo
    }
    
    struct Feedback {
        static let site = UIImage(systemName:"tv")
    }
      
    struct Profil {
        static let exit = UIImage(named: "logoutIcon")
    }
    
    struct ListVote {
        static let filter = UIImage(systemName: "line.horizontal.3.decrease.circle")
    }
    
    struct TabBar {
        static let list = UIImage(named: "NavBarListIcon")
        static let map = UIImage(named: "NavBarMapIcon")
        static let feedback = UIImage(named: "editUserIcon")
        static let profil = UIImage(named: "NavBarProfileIcon")
    }
}
