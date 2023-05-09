//
//  BaseViewController.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit

class BaseViewController<T>: UIViewController, BaseViewControllerProtocol {
    let viewModel: T
    let bag = AnyCancelTaskBag()

    required init?(coder: NSCoder) {
        fatalError()
    }

    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupDefault()
        addUIComponents()
        configureLayouts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }

    func setupDefault() { }
    func addUIComponents() { }
    func configureLayouts() { }
    func bind() { }
}

