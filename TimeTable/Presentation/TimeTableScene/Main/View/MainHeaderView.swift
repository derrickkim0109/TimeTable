//
//  MainHeaderView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class MainHeaderView: BaseView {
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.text = "2023년 5월"
        return label
    }()

    let leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "lessthan"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 3
        return button
    }()

    let todayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .systemGray4
        label.text = "오늘"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 3
        return label
    }()

    let rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "greaterthan"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 3
        return button
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [dateTitleLabel,
         leftButton,
         todayLabel,
         rightButton].forEach { addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            dateTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            dateTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            dateTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            leftButton.leadingAnchor.constraint(equalTo: dateTitleLabel.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            todayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            todayLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 5),
            todayLabel.widthAnchor.constraint(equalToConstant: 45)
        ])

        NSLayoutConstraint.activate([
            rightButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            rightButton.leadingAnchor.constraint(equalTo: todayLabel.trailingAnchor, constant: 5),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
