//
//  BaseView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit

class BaseView: UIView, BaseViewProtocol {
    required init?(coder: NSCoder) {
        fatalError("init(coder :)")
    }

    required init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        setupDefault()
        addUIComponents()
        configureLayouts()
    }

    func setupDefault() { }
    func addUIComponents() { }
    func configureLayouts() { }
}
