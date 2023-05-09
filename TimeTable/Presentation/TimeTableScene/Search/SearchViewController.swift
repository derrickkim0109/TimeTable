//
//  SearchViewController.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func showLectureDetailViewController(
        at viewController: UIViewController,
        lecture: LectureEntity,
        memos: [MemoEntity]?)
}

final class SearchViewController: BaseViewController<SearchViewModel> {
    weak var coordinator: SearchViewControllerDelegate?

    private let searchView = SearchView()
    private var model: [LectureEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupDefault() {
        super.setupDefault()

        searchView.searchBarView.searchBar.delegate = self
        searchView.lectureCollectionView.delegate = self
        loadAllLecture()
    }

    override func addUIComponents() {
        super.addUIComponents()

        view.addSubview(searchView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    private func loadAllLecture() {
        Task { [weak self] in
            guard let `self` else {
                return
            }

            await self.viewModel.loadLectures()

            guard let state = self.viewModel.state else {
                return
            }

            switch state {
            case .success(let data):
                self.model = data
                self.searchView.updateDataSource(by: data, isSearched: false)
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

    private func didSearch(_ code: String?, _ lecture: String?) {
        Task { [weak self] in
            guard let `self` else {
                return
            }

            await self.viewModel.loadLectures(code: code, lecture: lecture)

            guard let state = self.viewModel.state else {
                return
            }

            switch state {
            case .success(let data):
                self.model = data
                self.searchView.updateDataSource(by: data, isSearched: true)
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
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }

        var code: String? = nil
        var lecture: String? = nil

        if searchBarText.contains("PG1807-") {
            code = searchBarText.uppercased()
        } else {
            lecture = searchBarText
        }

        searchBar.resignFirstResponder()

        didSearch(code, lecture)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.showLectureDetailViewController(at: self,
                                                     lecture: model[indexPath.row],
                                                     memos: nil)
    }
}
