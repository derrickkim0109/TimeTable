//
//  LectureInfoView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class LectureInfoView: BaseView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView,
                                                       dayDescriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()

    let dayDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    override func setupDefault() {
        super.setupDefault()

        translatesAutoresizingMaskIntoConstraints = false
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(stackView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
