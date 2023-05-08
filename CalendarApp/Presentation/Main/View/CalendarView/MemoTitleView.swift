//
//  MemoTitleView.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit

final class MemoTitleView: BaseView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [memoIconImageView,
                                                       memoTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()

    let memoIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 7)
        return label
    }()

    override func setupDefault() {
        super.setupDefault()
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
            memoIconImageView.widthAnchor.constraint(equalTo: memoIconImageView.heightAnchor),
            memoIconImageView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
}
