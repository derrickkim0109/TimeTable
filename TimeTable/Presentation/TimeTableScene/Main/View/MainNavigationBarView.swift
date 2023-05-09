//
//  MainNavigationBarView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class MainNavigationBarView: BaseView {
    private let viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "시간표"
        return label
    }()

    let searchButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .black
        return imageView
    }()

    private let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [viewTitleLabel,
         searchButtonImageView,
         borderView].forEach { addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            viewTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            viewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            searchButtonImageView.leadingAnchor.constraint(equalTo: viewTitleLabel.trailingAnchor),
            searchButtonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            searchButtonImageView.centerYAnchor.constraint(equalTo: viewTitleLabel.centerYAnchor),
            searchButtonImageView.heightAnchor.constraint(equalTo: searchButtonImageView.widthAnchor),
            searchButtonImageView.heightAnchor.constraint(equalToConstant: 25)
        ])

        NSLayoutConstraint.activate([
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
