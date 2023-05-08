//
//  BaseViewController.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit

class BaseViewController: UIViewController, BaseProtocol {
    required init?(coder: NSCoder) {
        fatalError()
    }

    required init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupDefault()
        addUIComponents()
        configureLayouts()
    }

    func setupDefault() { }
    func addUIComponents() { }
    func configureLayouts() { }
}

