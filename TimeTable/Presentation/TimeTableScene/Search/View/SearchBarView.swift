//
//  SearchBarView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class SearchBarView: BaseView {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false

        if let glassIconView = searchBar.searchTextField.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor.gray
        }

        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont(
            name: "PretendardVariable-Regular",
            size: 16)

        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "강의 검색",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])

        searchBar.layer.cornerRadius = 10.0
        searchBar.layer.backgroundColor = UIColor.clear.cgColor
        searchBar.layer.masksToBounds = true
        searchBar.showsCancelButton = false

        return searchBar
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        addSubview(searchBar)
    }

    override func configureLayouts() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 7),
            searchBar.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            searchBar.searchTextField.centerXAnchor.constraint(
                equalTo: searchBar.centerXAnchor),
            searchBar.searchTextField.centerYAnchor.constraint(
                equalTo: searchBar.centerYAnchor),

            searchBar.searchTextField.heightAnchor.constraint(
                equalToConstant: 39),
            searchBar.searchTextField.widthAnchor.constraint(
                equalTo: searchBar.widthAnchor,
                multiplier: 0.95)
        ])
    }
}
