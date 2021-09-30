//
//  ViewController + progress.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import UIKit
import MBProgressHUD


protocol ProgressProtocol {
    func showProgressHUD()
    func showProgressHUD(message: String)
    func hideProgressHUD()
}

extension UIViewController: ProgressProtocol {
    func showProgressHUD() {
        showProgressHUD(message: "")
    }

    func showProgressHUD(message: String) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
        hud.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        hud.alpha = 0.2
        hud.backgroundView.style = .blur
        hud.bezelView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        hud.contentColor = UIColor.black
        hud.removeFromSuperViewOnHide = true
    }

    func hideProgressHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

