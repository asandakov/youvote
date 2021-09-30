//
//  VoteTableViewCell.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class VoteTableViewCell: UITableViewCell {

    static let reuseId = "VoteTableViewCell"
    
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
        question.font = Fonts.Text.textSemiboldFont(size: 14.0)
        question.numberOfLines = 3
        question.textColor = Colors.Common.grayColor
        question.translatesAutoresizingMaskIntoConstraints = false
        return question
    }()
    
           

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(countLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(questionLabel)
        
                                     
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
      
       
    
    func setConstraint() {

        countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: countLabel.topAnchor).isActive = true
             
        
        questionLabel.leadingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: 5).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: -5).isActive = true
        questionLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 10).isActive = true
         
    }

}
