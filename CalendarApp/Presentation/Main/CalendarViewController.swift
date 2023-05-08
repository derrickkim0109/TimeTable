//
//  CalendarViewController.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

final class CalendarViewController: BaseViewController {

    private let viewModel = CalendarViewModel()
    private let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupDefault() {
        super.setupDefault()

        navigationController?.isNavigationBarHidden = true
        setupCalendarView()
        setupNaviBar()
    }

    override func addUIComponents() {
        super.addUIComponents()

        view.addSubview(mainView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        JZWeekViewHelper.viewTransitionHandler(to: size, weekView: mainView.calendarView)
    }

    private func setupCalendarView() {
        mainView.calendarView.baseDelegate = self

        mainView.calendarView.setupCalendar(numOfDays: 5,
                                       setDate: Date(),
                                       allEvents: viewModel.eventsByDate,
                                       scrollType: .pageScroll)

        mainView.calendarView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: JZHourGridDivision.noneDiv))
    }

    private func setupNaviBar() {
        updateNaviBarTitle()
        let optionsButton = UIButton(type: .system)
        optionsButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        optionsButton.frame.size = CGSize(width: 25, height: 25)
        if #available(iOS 11.0, *) {
            optionsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
            optionsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }

        optionsButton.addTarget(self, action: #selector(presentOptionsVC), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)
    }

    private func updateNaviBarTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY MM"

        self.navigationItem.title = dateFormatter.string(
            from: mainView.calendarView.initDate.add(
                component: .day,
                value: mainView.calendarView.numOfDays)).korean
    }

    @objc func presentOptionsVC() {

    }
}

extension CalendarViewController: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        updateNaviBarTitle()
    }
}
