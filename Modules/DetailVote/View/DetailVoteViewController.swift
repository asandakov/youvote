//
//  DetailVoteViewController.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class DetailVoteViewController: UIViewController, DetailVoteViewControllerProtocol {

    var presenter: DetailVoteViewPresenterProtocol!
    var vote: Vote?
    private var heightVariantConstraint:NSLayoutConstraint?
    private let heightCellVariant:CGFloat = 40
    private var curIdVariant:Int = 0
    
    let countLabel:UILabel = {
       let count = UILabel()
        count.font = Fonts.Text.textSemiboldFont(size: 14.0)
        count.numberOfLines = 2
        count.textColor = Colors.Common.grayLightColor
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    
    let dateLabel:UILabel = {
       let date = UILabel()
        date.font = Fonts.Text.textSemiboldFont(size: 14.0)
        date.numberOfLines = 2
        date.textColor = Colors.Common.grayLightColor
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let questionLabel:UILabel = {
       let question = UILabel()
        question.font = Fonts.Text.textSemiboldFont(size: 16.0)
        question.numberOfLines = 0
        question.textColor = Colors.Common.grayColor
        question.translatesAutoresizingMaskIntoConstraints = false
        return question
    }()
    

    let variantTableView: UITableView = {
        let list = UITableView()
        list.register(VariantTableViewCell.self, forCellReuseIdentifier: VariantTableViewCell.reuseId)
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    
    let sendBotton:UIButton = {
        let send = UIButton(type: .system)
        send.frame = CGRect(x: 0, y: 0, width: 230, height: 40)
        send.setTitleColor(Colors.Button.text, for: .normal)
        send.setTitle(Localization.DetailVote.send, for: .normal)
        send.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        send.backgroundColor = Colors.Button.background
        send.layer.cornerRadius = 5
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Localization.DetailVote.title
        let instItem = UIBarButtonItem(image: Images.App.inst, style: .plain, target: self, action: #selector(openInst))
        let telegramItem = UIBarButtonItem(image: Images.App.telegram, style: .plain, target: self, action: #selector(openTelegram))
        self.navigationItem.rightBarButtonItems = [telegramItem,instItem]
        
        
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      
        view.addSubview(countLabel)
        view.addSubview(dateLabel)
        view.addSubview(questionLabel)
        view.addSubview(variantTableView)
        view.addSubview(sendBotton)
        
               
        variantTableView.delegate = self
        variantTableView.dataSource = self
        
        sendBotton.addTarget(self, action: #selector(sendPoll), for: .touchUpInside)
        
        setConstraint()
        
        self.presenter.getVote()
    }
 
    @objc func openInst(){
        
        guard let curVote = self.vote else {
            return
        }
        
        if let url = URL(string: curVote.urlInst) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func openTelegram(){
        
        guard let curVote = self.vote else {
            return
        }
        if let url = URL(string: curVote.urlTelegram) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    @objc func sendPoll(){
        self.presenter.sendPoll(idVariant:curIdVariant)
    }
    
    
    func setVote(vote: Vote) {
        self.vote = vote
        questionLabel.text = vote.question  
        countLabel.text = Localization.ListVote.countParam.replacingOccurrences(of: "%s", with: "\(vote.countVote)")
        dateLabel.text = Localization.ListVote.dateParam.replacingOccurrences(of: "%s", with: "\(vote.endDate)")
        
        variantTableView.reloadData()

        self.heightVariantConstraint?.isActive = false
        self.heightVariantConstraint = self.variantTableView.heightAnchor.constraint(equalToConstant: heightCellVariant*CGFloat(vote.variant.count))
        self.heightVariantConstraint?.isActive = true
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
  
    func setConstraint() {

        countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: countLabel.topAnchor).isActive = true
                       
        questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        questionLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 15).isActive = true
        
        variantTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        variantTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        variantTableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10).isActive = true

        sendBotton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendBotton.topAnchor.constraint(equalTo: variantTableView.bottomAnchor, constant: 15).isActive = true
        sendBotton.widthAnchor.constraint(equalToConstant: sendBotton.frame.width).isActive = true
        sendBotton.heightAnchor.constraint(equalToConstant: sendBotton.frame.height).isActive = true

    }
}


extension DetailVoteViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vote?.variant.count ?? 0
    }
      
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VariantTableViewCell.reuseId, for: indexPath) as? VariantTableViewCell else {
            return UITableViewCell()
        }
        
        guard let variant = self.vote?.variant else {
            return UITableViewCell()
        }
       
        cell.variantLabel.text = variant[indexPath.row].name + " - " +  String(variant[indexPath.row].percent)+"%"
        cell.pictureImageView.image = variant[indexPath.row].icon
        
        cell.selectionStyle = .none
              
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCellVariant
    }
           
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    
        guard let variants = self.vote?.variant else {
            return
        }
        for i in 0 ..< variants.count {
            self.vote?.variant[i].icon = Images.App.notChecked
        }
        self.vote?.variant[indexPath.row].icon = Images.App.Checked
        self.curIdVariant = Int(self.vote?.variant[indexPath.row].id ?? "") ?? 0
        variantTableView.reloadData()
    }
    
  

}

