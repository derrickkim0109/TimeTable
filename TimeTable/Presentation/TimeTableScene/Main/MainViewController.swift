//
//  MainViewController.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

protocol MainViewControllerDelegate: AnyObject {
    func showSearchViewController(
        at viewController: UIViewController)

    func showLectureDetailViewController(
        at viewController: UIViewController,
        lecture: LectureEntity,
        memos: [MemoEntity]?)
}

final class MainViewController: BaseViewController <MainViewModel> {
    private let mainView = MainView()
    
    weak var coordinator: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupDefault() {
        super.setupDefault()

        setupCalendarView()
        setupTapGestures()
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

    override func bind() {
        fetchTimeTable()
        self.mainView.calendarView.collectionView.reloadData()
        self.mainView.calendarView.flowLayout.collectionView?.reloadData()
    }

    private func fetchTimeTable() {
        Task { [weak self] in
            guard let `self` else {
                return
            }
 
            await self.viewModel.loadLectures()

            await MainActor.run() {
                self.mainView.calendarView.setupCalendar(numOfDays: 5,
                                                         setDate: Date(),
                                                         allEvents: self.viewModel.eventsByDate,
                                                         scrollType: .pageScroll)
            }

            guard let state = self.viewModel.state else {
                return
            }

            switch state {
            case .failed(let errorMessage):
                await AlertControllerBulider.Builder()
                    .setTitle("알림")
                    .setMessag(errorMessage)
                    .setConfrimText("확인")
                    .build()
                    .present()
            }
        }.store(in: bag)
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        JZWeekViewHelper.viewTransitionHandler(to: size, weekView: mainView.calendarView)
    }

    private func setupCalendarView() {
        mainView.calendarView.baseDelegate = self
        mainView.calendarView.updateFlowLayout(JZWeekViewFlowLayout(
            hourGridDivision: JZHourGridDivision.noneDiv))
    }

    private func updateNaviBarTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY MM"

        mainView.mainHeaderView.dateTitleLabel.text = dateFormatter.string(
            from: mainView.calendarView.initDate.add(
                component: .day,
                value: mainView.calendarView.numOfDays)).korean
    }

    private func setupTapGestures() {
        let tabSearchButton = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapSearchButton(_:)))

        mainView.navigationBarView.searchButtonImageView.isUserInteractionEnabled = true
        mainView.navigationBarView.searchButtonImageView.addGestureRecognizer(tabSearchButton)
    }

    @objc private func didTapSearchButton(_ sender: UIGestureRecognizer) {
        coordinator?.showSearchViewController(at: self)
    }
}

extension MainViewController: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        updateNaviBarTitle()
    }
}
