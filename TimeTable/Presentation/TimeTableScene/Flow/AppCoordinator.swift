//
//  AppCoordinator.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start() -> UINavigationController
}

final class AppCoordinator: Coordinator,
                            MainCoordinatorDelegate,
                            SearchViewControllerDelegate,
                            LectureDetailViewControllerDelegate,
                            MemoViewControllerDelegate {
    var childCoordinators = [Coordinator]()
    private var window: UIWindow?

    private lazy var appConfiguration = AppConfiguration()
    private lazy var apiDataTransferService: DataTransferService = {
        let configuration = APIDataNetworkConfiguration(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            headers: HTTPHeaderField.json(key: appConfiguration.apiKey).header)

        let apiDataNetwork = DefaultNetworkService(
            config: configuration)
        return DefaultDataTransferService(
            with: apiDataNetwork)
    }()

    init(window: UIWindow?) {
        self.window = window
    }

    @discardableResult
    func start() -> UINavigationController {
        let rootViewController = mainNavigationController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return UINavigationController()
    }

    private func mainNavigationController() -> UINavigationController {
        let coordinator = MainCoordinator(
            apiDataTransferService: apiDataTransferService)

        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        let calendarNC = coordinator.start()
        return calendarNC
    }

    func showSearchViewController(at viewController: UIViewController) {
        let repository: LecturesRepository = DefaultLecturesRepository(
            dataTransferService: apiDataTransferService)
        let useCase: FetchLecturesUseCase = DefaultFetchLecturesUseCase(
            lecturesRepository: repository)
        let viewModel = DefaultSearchViewModel(
            fetchLecturesUseCase: useCase)

        let searchViewController = SearchViewController(viewModel: viewModel)
        searchViewController.title = "강의 검색"
        searchViewController.coordinator = self

        viewController.navigationController?.isNavigationBarHidden = false

        viewController.navigationController?.pushViewController(searchViewController, animated: true)
    }

    func showLectureDetailViewController(at viewController: UIViewController,
                                         lecture: LectureEntity,
                                         memos: [MemoEntity]?) {
        let title = viewController is SearchViewController == true ? "강의 추가" : "메모 추가"

        let timeTableRepository: TimeTableRepository = DefaultTimeTableRepository(
            dataTransferService: apiDataTransferService)
        let enrollTimeTableUseCase: EnrollTimeTableUseCase = DefaultEnrollTimeTableUseCase(
            timeTableRepository: timeTableRepository)

        let deleteTimeTableUseCase: DeleteTimeTableUseCase = DefaultDeleteTimeTableUseCase(
            timeTableRepository: timeTableRepository)

        let memoRepository: MemoRepository = DefaultMemoRepository(
            dataTransferService: apiDataTransferService)
        let fetchMemosUseCase: FetchMemosUseCase = DefaultFetchMemosUseCase(
            memoRepository: memoRepository)
        let deleteMemoUseCase: DeleteMemoUseCase = DefaultDeleteMemoUseCase(
            memoRepository: memoRepository)

        let viewModel = DefaultLectureDetailViewModel(
            enrollTimeTableUseCase: enrollTimeTableUseCase,
            deleteTimeTableUseCase: deleteTimeTableUseCase,
            fetchMemosUseCase: fetchMemosUseCase,
            deleteMemoUseCase: deleteMemoUseCase)

        let lectureDetailViewController = LectureDetailViewController(viewModel: viewModel)
        lectureDetailViewController.title = title
        lectureDetailViewController.coordinator = self
        lectureDetailViewController.lectureModel = lecture
        lectureDetailViewController.memoModel = memos

        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationController?.pushViewController(lectureDetailViewController, animated: true)
    }

    func showMemoViewController(at viewController: UIViewController, code: String) {
        let title = "메모 등록"

        let memoRepository: MemoRepository = DefaultMemoRepository(
            dataTransferService: apiDataTransferService)
        let enrollMemoUseCase: EnrollMemoUseCase = DefaultEnrollMemoUseCase(
            memoRepository: memoRepository)

        let viewModel = DefaultMemoViewModel(enrollMemoUseCase: enrollMemoUseCase)

        let memoViewController = MemoViewController(viewModel: viewModel)
        memoViewController.title = title
        memoViewController.lectureCode = code
        memoViewController.coordinator = self

        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationController?.pushViewController(memoViewController, animated: true)
    }

    func didFinish() {
        childDidFinish(self)
    }

    func popToRootViewController(at viewController: UIViewController) {
        viewController.navigationController?.popToRootViewController(animated: false)
    }

    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
