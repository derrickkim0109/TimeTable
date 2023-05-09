//
//  MainCoordinator.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func showSearchViewController(at viewController: UIViewController)
    func showLectureDetailViewController(at viewController: UIViewController,
                                         lecture: LectureEntity,
                                         memos: [MemoEntity]?)
}

class MainCoordinator: Coordinator,
                       MainCoordinatorDelegate,
                       MainViewControllerDelegate,
                       SearchViewControllerDelegate {
    weak var parentCoordinator: MainCoordinatorDelegate?

    var childCoordinators = [Coordinator]()
    private var navigationController = UINavigationController()
    private let apiDataTransferService: DataTransferService

    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }

    func start() -> UINavigationController {
        let searchViewController = setViewController()
        return setNavigationController(with: searchViewController)
    }

    private func setViewController() -> UIViewController {
        let lecturesRepository: LecturesRepository = DefaultLecturesRepository(
            dataTransferService: apiDataTransferService)
        let fetchLecturesUseCase: FetchLecturesUseCase = DefaultFetchLecturesUseCase(
            lecturesRepository: lecturesRepository)

        let timeTableRepository: TimeTableRepository = DefaultTimeTableRepository(
            dataTransferService: apiDataTransferService)
        let fetchTimeTableUseCase: FetchTimeTableUseCase = DefaultFetchTimeTableUseCase(
            timeTableRepository: timeTableRepository)

        let memoRepository: MemoRepository = DefaultMemoRepository(
            dataTransferService: apiDataTransferService)
        let fetchMemosUseCase: FetchMemosUseCase = DefaultFetchMemosUseCase(
            memoRepository: memoRepository)
        
        let viewModel = DefaultMainViewModel(
            fetchLecturesUseCase: fetchLecturesUseCase,
            fetchTimeTableUseCase: fetchTimeTableUseCase,
            fetchMemosUseCase: fetchMemosUseCase)

        let viewController = MainViewController(viewModel: viewModel)
        viewController.coordinator = self
        return viewController
    }

    private func setNavigationController(
        with viewController: UIViewController) -> UINavigationController {
            navigationController.setViewControllers(
                [viewController],
                animated: false)
            navigationController.isNavigationBarHidden = true

            return navigationController
        }

    func showSearchViewController(at viewController: UIViewController) {
        parentCoordinator?.showSearchViewController(at: viewController)
    }

    func showLectureDetailViewController(at viewController: UIViewController, lecture: LectureEntity, memos: [MemoEntity]?) {
        parentCoordinator?.showLectureDetailViewController(at: viewController, lecture: lecture, memos: memos)
    }
}
