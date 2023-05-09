//
//  BaseProtocol.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

protocol BaseViewControllerProtocol {
    associatedtype T
    init(viewModel: T)
    func setupDefault()
    func addUIComponents()
    func configureLayouts()
}

protocol BaseViewProtocol {
    init()
    func setupDefault()
    func addUIComponents()
    func configureLayouts()
}
