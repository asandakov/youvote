//
//  FilterListVoteViewController.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import UIKit

class FilterListVoteViewController: UIViewController, FilterListVoteViewControllerProtocol {

    var presenter: FilterListVoteViewPresenterProtocol!
    var topic:[TopicTable]? {
        didSet {
            topicPicker.reloadAllComponents()
        }
    }
    
 
    let titleTopicLabel: UILabel = {
       let title = UILabel()
       title.font = Fonts.Text.textSemiboldFont(size: 14.0)
       title.text = Localization.FilterListVote.topicParam
       title.numberOfLines = 1
       title.textColor = Colors.Param.title
       title.translatesAutoresizingMaskIntoConstraints = false
       return title
    }()
    
    
    let topicPicker: UIPickerView = {
        let topic = UIPickerView()
        topic.translatesAutoresizingMaskIntoConstraints = false
        return topic
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Localization.FilterListVote.title
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
     
        view.addSubview(titleTopicLabel)
        view.addSubview(topicPicker)
       
        topicPicker.delegate = self
        
        presenter.getParamFilter()
        
        setConstraints()
    }
  
    func setFilter(topic:[TopicTable]) {        
        self.topic = topic
        self.presenter.getCurTopic()
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
    
    func setCurTopic(curTopic: TopicTable?){
        
        guard let curentTopic = curTopic else {
            topicPicker.selectRow(0, inComponent: 0, animated: false)
            guard let cursTopic = self.topic?[0] else {
               return
            }
            self.presenter.setCurTopic(idTopic:cursTopic.id)
            return
        }
        
        
        self.topic?.enumerated().forEach {
            (i, el) in
            
            if el.id == curentTopic.id {
                topicPicker.selectRow(i, inComponent: 0, animated: false)
            }          
        }
    }
    
    private func setConstraints() {
      
      
        titleTopicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleTopicLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
  
      
        topicPicker.leadingAnchor.constraint(equalTo: titleTopicLabel.leadingAnchor).isActive = true
        topicPicker.topAnchor.constraint(equalTo: titleTopicLabel.bottomAnchor, constant: 5).isActive = true
 
 
    }
    
}


extension FilterListVoteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return topic?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return topic?[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        guard let curTopic = self.topic?[row] else {
           return
        }
        
        self.presenter.setCurTopic(idTopic:curTopic.id)
    }


}
