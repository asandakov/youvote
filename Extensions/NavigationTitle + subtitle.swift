//
//  NavigationTitle + subtitle.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import UIKit


class NavigationTitleView: UIView {

    private var contentStackView = UIStackView()
    private var titleLabel = UILabel()
    private var subTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewConfig()
        addViewsConfig()
        layoutViewsConfig()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func set(title: String, subTitle: String){

        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle

    }

    private func viewConfig() {

        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        contentStackView.distribution  = .fill
        contentStackView.spacing = 3


        self.backgroundColor = .clear
        self.titleLabel.textColor = Colors.Navigation.title
        self.titleLabel.font = Fonts.Text.textSemiboldFont(size: 20.0)
        self.subTitleLabel.textColor = Colors.Navigation.titleSub
        self.subTitleLabel.font = Fonts.Text.textSemiboldFont(size: 14.0)
    }

    private func addViewsConfig() {
       
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subTitleLabel)
        self.addSubview(contentStackView)

    }

    private func layoutViewsConfig(){
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true

    }

}
