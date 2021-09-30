//
//  ViewController + alert.swift
//  Flowers
//
//  Created by Алексей on 26.12.2020.
//

import UIKit

protocol showAlertProtocol:class {
    func showMsgAlert(message: String) -> ()
    func showAlert(tite: String, message: String, okButton: String, handlerOkButton: (()->())?, canselButton: String?, handlerokCanselButton: (()->())?) -> ()
        
    func showPickerAlert(picker:UIPickerView,tite: String, okButton: String, handlerOkButton: (()->())?, canselButton: String?, handlerokCanselButton: (()->())?) -> ()
}

extension UIViewController: showAlertProtocol{
    
    func showMsgAlert(message: String){
        self.showAlert(message: message)
    }
    
    
    func showAlert(tite: String = Localization.Alert.tite, message: String, okButton: String = Localization.Alert.okButton, handlerOkButton: (()->())? = nil, canselButton: String? = nil, handlerokCanselButton: (()->())? = nil){
 
        let alertController = UIAlertController(title: tite, message: message, preferredStyle: .alert)
        let actionOkAlert = UIAlertAction(title: okButton, style: .default) { _ in
            
            guard let handlerOkButton = handlerOkButton else { return }
            handlerOkButton()
            
        }
        alertController.addAction(actionOkAlert)
        
        
        if let canselButton = canselButton{
           
            let actionCanselAlert = UIAlertAction(title: canselButton, style: .cancel) { _ in
                
                guard let handlerokCanselButton = handlerokCanselButton else { return }
                handlerokCanselButton()
           
            }
            
            alertController.addAction(actionCanselAlert)
        }
             
       
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    func showPickerAlert(picker:UIPickerView, tite: String = Localization.Alert.tite, okButton: String = Localization.Alert.okButton, handlerOkButton: (()->())? = nil, canselButton: String? = nil, handlerokCanselButton: (()->())? = nil){

        let alertController = UIAlertController(title: tite, message:  "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        let actionOkAlert = UIAlertAction(title: okButton, style: .default) { _ in
            
            guard let handlerOkButton = handlerOkButton else { return }
            handlerOkButton()
            
        }
        
        picker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        alertController.view.addSubview(picker)
        alertController.addAction(actionOkAlert)
               
        if let canselButton = canselButton{
           
            let actionCanselAlert = UIAlertAction(title: canselButton, style: .cancel) { _ in
                
                guard let handlerokCanselButton = handlerokCanselButton else { return }
                handlerokCanselButton()
           
            }
            
            alertController.addAction(actionCanselAlert)
        }
             
     
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}
