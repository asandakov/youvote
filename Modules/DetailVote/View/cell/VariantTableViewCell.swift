//
//  VariantTableViewCell.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import UIKit

class VariantTableViewCell: UITableViewCell {

    static let reuseId = "VariantTableViewCell"
       
    
    
    let pictureImageView:UIImageView = {
       let img = UIImageView()
       img.translatesAutoresizingMaskIntoConstraints = false
       img.contentMode = .scaleAspectFit
       img.image = Images.App.notChecked
       img.tintColor = Colors.Common.brownColor
       return img
    }()
    
    let variantLabel:UILabel = {
       let variant = UILabel()
        variant.font = Fonts.Text.textSemiboldFont(size: 14.0)
        variant.numberOfLines = 0
        variant.textColor = Colors.Common.grayColor
        variant.translatesAutoresizingMaskIntoConstraints = false
        return variant
    }()
    

           

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     
        super.init(style:style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(pictureImageView)
        contentView.addSubview(variantLabel)
        
                                     
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
      
       
    
    func setConstraint() {

   
        pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/4).isActive = true
        pictureImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        pictureImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        
        variantLabel.topAnchor.constraint(equalTo: pictureImageView.topAnchor).isActive = true
        variantLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: 10).isActive = true        
    }

}
