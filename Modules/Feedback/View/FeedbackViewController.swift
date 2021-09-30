//
//  FeedbackViewController.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class FeedbackViewController: UIViewController, UITextViewDelegate, FeedbackViewControllerProtocol {

    var presenter: FeedbackViewPresenterProtocol!
   
    let borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
  
    let nameLabel: UILabel = {
       let name = UILabel()
       name.numberOfLines = 0
       name.font = Fonts.Text.textSemiboldFont(size: 16.0)
       name.text = Localization.Feedback.titleSub
       name.textColor = Colors.Common.grayColor
       name.textAlignment = .center
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
    
    let errorLabel: UILabel = {
        let error = UILabel()
        error.font = Fonts.Text.textSemiboldFont(size: 12.0)
        error.text = " "
        error.numberOfLines = 0
        error.textColor = Colors.Common.readColor
        error.translatesAutoresizingMaskIntoConstraints = false
       return error
    }()
    
    
    let nameTextField: UITextField = {
       let name = UITextField()
        name.frame.size = CGSize(width: 270, height: 40)
        name.borderStyle = .roundedRect
        name.layer.borderWidth = 1.0
        name.layer.cornerRadius = 5.0
        name.placeholder = Localization.Feedback.fioParam
        name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
    let emailTextField: UITextField = {
       let email = UITextField()
        email.frame.size = CGSize(width: 270, height: 40)
        email.borderStyle = .roundedRect
        email.layer.borderWidth = 1.0
        email.layer.cornerRadius = 5.0
        email.placeholder = Localization.Feedback.emailParam
        email.translatesAutoresizingMaskIntoConstraints = false
       return email
    }()
    
    
    let msgTextField: UITextView = {
       let msg = UITextView()
        msg.frame.size = CGSize(width: 270, height: 115)
        msg.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        msg.textColor = UIColor.lightGray
        msg.layer.borderWidth = 1.0
        msg.layer.cornerRadius = 5.0
        msg.text = Localization.Feedback.textParam
        msg.translatesAutoresizingMaskIntoConstraints = false
       return msg
    }()
      
    
    let sendBotton:UIButton = {
        let send = UIButton(type: .system)
        send.frame = CGRect(x: 0, y: 0, width: 270, height: 50)
        send.setTitleColor(Colors.Button.text, for: .normal)
        send.setTitle(Localization.Feedback.sendParam, for: .normal)
        send.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        send.backgroundColor = Colors.Button.background
        send.layer.cornerRadius = 5
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    let text: UITextView = {
        let text =  UITextView()
        text.frame.size = CGSize(width: 270, height: 40)
        text.font = Fonts.Text.textSemiboldFont(size: 12.0)
        text.textColor = Colors.Common.grayColor
        text.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: Localization.Feedback.text)
        let policyURL = URL(string: Settings.policyURL)!
        attributedString.setAttributes([.link: policyURL], range: NSMakeRange(31, attributedString.length - 31))
        text.attributedText = attributedString
        text.isUserInteractionEnabled = true
        text.linkTextAttributes = [.foregroundColor: Colors.Common.brownColor]
        text.textAlignment = .center
        text.isEditable = false
        text.isScrollEnabled = false

        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localization.Feedback.title
        let siteItem = UIBarButtonItem(image: Images.Feedback.site, style: .plain, target: self, action: #selector(openSite))     
        self.navigationItem.rightBarButtonItems = [siteItem]
        
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(nameLabel)
        view.addSubview(errorLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(msgTextField)
        view.addSubview(sendBotton)
        view.addSubview(text)
        
        msgTextField.delegate = self
        
        msgTextField.layer.borderColor = borderColor.cgColor
        nameTextField.layer.borderColor = borderColor.cgColor
        emailTextField.layer.borderColor = borderColor.cgColor
        msgTextField.font = emailTextField.font
        
        sendBotton.addTarget(self, action: #selector(sendFeedback), for: .touchUpInside)
        
        setConstraints()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = emailTextField.textColor
        }
    }
  
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Localization.Feedback.textParam
            textView.textColor = UIColor.lightGray
        }
    }
    
   
    @objc func openSite(){
        if let url = URL(string: Settings.siteURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    @objc func sendFeedback(){
    
        errorLabel.text = " "
        
        
        guard  let name = nameTextField.text else{
            return
        }
        
        guard var email = emailTextField.text else{
            return
        }
        
        guard let msg = msgTextField.text else{
            return
        }
            
      
        email = email.replacingOccurrences(of: " ", with: "")
        if (!email.isValidEmail){
           errorLabel.text = Localization.Feedback.emailParamNo
           return
        }
        
        if (name == ""){
           errorLabel.text = Localization.Feedback.fioParamNo
           return
        }
        
        if (msg == ""){
           errorLabel.text = Localization.Feedback.textParamNo
           return
        }
 
        view.endEditing(true)
        
        presenter.sendFeedback(name:name, email:email, text:msg)
  
    }
    
    
    func clear() {
        nameTextField.text = ""
        emailTextField.text = ""
        msgTextField.text = ""
    }
    
    
    func showMessage(message: String) {
       self.showAlert(message: message)
    }
    
    
    func startProgress() {
        self.showProgressHUD()
    }
    
    func endProgress() {
        self.hideProgressHUD()
    }
    
    private func setConstraints() {

        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true


        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        
        
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 15).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: nameTextField.frame.width).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: nameTextField.frame.height).isActive = true
        
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: emailTextField.frame.width).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: emailTextField.frame.height).isActive = true
        
               
        
        msgTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        msgTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
        msgTextField.widthAnchor.constraint(equalToConstant: msgTextField.frame.width).isActive = true
        msgTextField.heightAnchor.constraint(equalToConstant: msgTextField.frame.height).isActive = true
                
        
        sendBotton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendBotton.topAnchor.constraint(equalTo: msgTextField.bottomAnchor, constant: 15).isActive = true
        sendBotton.widthAnchor.constraint(equalToConstant: sendBotton.frame.width).isActive = true
        sendBotton.heightAnchor.constraint(equalToConstant: sendBotton.frame.height).isActive = true
        
        text.topAnchor.constraint(equalTo: sendBotton.bottomAnchor, constant: 15).isActive = true
        text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
   
    }
    
}
