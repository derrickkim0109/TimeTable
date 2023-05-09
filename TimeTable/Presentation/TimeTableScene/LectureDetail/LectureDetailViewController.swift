//
//  LectureDetailViewController.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

protocol LectureDetailViewControllerDelegate: AnyObject {
    func didFinish()
    func popToRootViewController(at: UIViewController)
    func showMemoViewController(
        at viewController: UIViewController,
        code: String)
}

final class LectureDetailViewController: BaseViewController<LectureDetailViewModel> {
    private let lectureDetailView = LectureDetailView()

    weak var coordinator: LectureDetailViewControllerDelegate?
    var lectureModel: LectureEntity?
    var memoModel: [MemoEntity]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupDefault() {
        super.setupDefault()
        
        updateUI(lectureModel, memoModel)
    }

    override func addUIComponents() {
        super.addUIComponents()

        view.addSubview(lectureDetailView)
    }

    override func bind() {
        super.bind()

        loadMemos(lectureModel?.code)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            lectureDetailView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            lectureDetailView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            lectureDetailView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            lectureDetailView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)
        ])

        NSLayoutConstraint.activate([
            lectureDetailView.enrollButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            lectureDetailView.enrollButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            lectureDetailView.enrollButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            lectureDetailView.enrollButton.heightAnchor.constraint(
                equalToConstant: 70)
        ])
    }

    private func configureNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "등록취소",
            style: .plain,
            target: self,
            action: #selector(didTapDeleteButton))
    }

    private func updateUI(_ lectureModel: LectureEntity?, _ memoModel: [MemoEntity]?) {
        guard let model = lectureModel else {
            return
        }

        lectureDetailView.titleLabel.text = model.lecture

        lectureDetailView.lectureTimeView.iconImageView.image = UIImage(
            systemName: "alarm")
        lectureDetailView.lectureTimeView.dayDescriptionLabel.text =
        "강의 시간 : " + model.convertLectureSchedule()

        lectureDetailView.lectureCodeView.iconImageView.image = UIImage(
            systemName: "chevron.left.forwardslash.chevron.right")
        lectureDetailView.lectureCodeView.dayDescriptionLabel.text =
        "교과목 코드 : " + model.code

        lectureDetailView.lectureProfessorView.iconImageView.image = UIImage(
            systemName: "graduationcap.fill")
        lectureDetailView.lectureProfessorView.dayDescriptionLabel.text =
        "담당 교수 : " + model.professor

        lectureDetailView.lectureLocationView.iconImageView.image = UIImage(
            systemName: "building.2.fill")
        lectureDetailView.lectureLocationView.dayDescriptionLabel.text =
        "강의실 : " + model.location

        if title == "강의 추가" {
            lectureDetailView.enrollButton.setTitle("강의 추가", for: .normal)
            lectureDetailView.enrollButton.addTarget(self,
                                                     action: #selector(didTapTimeTableEnrollment(_:)),
                                                     for: .touchUpInside)
            lectureDetailView.memoStackView.isHidden = true
        } else {
            lectureDetailView.enrollButton.setTitle("메모 추가", for: .normal)
            lectureDetailView.enrollButton.addTarget(self,
                                                     action: #selector(didTapMemoEnrollment(_:)),
                                                     for: .touchUpInside)
            lectureDetailView.memoStackView.isHidden = false

            configureNavigationItems()
            lectureDetailView.makeMemoViews(memoModel ?? [])
        }
    }

    func didEnrollTimeTable() {
        coordinator?.didFinish()
    }

    func didEnrollTimeTable(_ code: String?) {
        Task { [weak self] in
            guard let code = code,
                  let `self` = self else {
                return
            }

            await self.viewModel.didTapEnrollTimeTableButton(code)

            guard let state = self.viewModel.state else {
                return
            }

            switch state {
            case .success:
                self.coordinator?.didFinish()
                self.coordinator?.popToRootViewController(at: self)
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

    private func didDeleteTimeTable(_ code: String?) {
        Task { [weak self] in
            guard let code = code,
                  let `self` = self else {
                return
            }

            await self.viewModel.didTapDeleteTimeTableButton(code)

            guard let state = self.viewModel.state else {
                return
            }

            switch state {
            case .success:
                self.coordinator?.didFinish()
                self.coordinator?.popToRootViewController(at: self)
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

    private func showWarningAlert() {
        Task {
            await AlertControllerBulider.Builder()
                .setTitle("알림")
                .setMessag("강의 등록을 취소하시겠습니까?")
                .setConfrimText("확인")
                .setConfirmAction { [weak self] _ in
                    guard let `self` = self else {
                        return
                    }

                    self.didDeleteTimeTable(self.lectureModel?.code)
                }
                .setDestructiveStyleCancelText("취소")
                .build()
                .present()
        }.store(in: bag)
    }

    func didDeleteMemo(_ memoEntity: MemoEntity?) {
        Task { [weak self] in
            guard let memoEntity = memoEntity,
                  let `self` = self else {
                return
            }

            await self.viewModel.didTapDeleteMemoButton(memoEntity)

            guard let state = self.viewModel.state else {
                return
            }

            switch state {
            case .success:
                break
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

    func loadMemos(_ code: String?) {
        Task { [weak self] in
            guard let code = code,
                  let `self` = self else {
                return
            }

            await self.viewModel.loadMemos(code)

            guard let state = self.viewModel.memoState else {
                return
            }

            switch state {
            case .success(let memos):
                self.memoModel = memos
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

    @objc private func didTapTimeTableEnrollment(_ sender: UIButton) {
        didEnrollTimeTable(lectureModel?.code)
    }

    @objc private func didTapMemoEnrollment(_ sender: UIButton) {
        guard let code = lectureModel?.code else {
            return
        }

        coordinator?.showMemoViewController(at: self, code: code)
    }
    
    @objc private func didTapDeleteButton() {
        showWarningAlert()
    }
}
