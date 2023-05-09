//
//  MemoViewController.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

protocol MemoViewControllerDelegate: AnyObject {
    func didFinish()
    func popToRootViewController(at: UIViewController)
}

final class MemoViewController: BaseViewController<MemoViewModel> {
    weak var coordinator: MemoViewControllerDelegate?

    private let memoView = MemoView()

    var lectureCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupDefault() {
        super.setupDefault()

        memoView.descriptionTextView.delegate = self
        setupButton()
    }

    override func addUIComponents() {
        super.addUIComponents()

        view.addSubview(memoView)
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            memoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            memoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            memoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            memoView.enrollButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            memoView.enrollButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            memoView.enrollButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            memoView.enrollButton.heightAnchor.constraint(
                equalToConstant: 70)
        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupButton() {
        memoView.enrollButton.addTarget(self,
                                        action: #selector(didTapMemoEnrollmentButton),
                                        for: .touchUpInside)
    }

    func didEnrollMemo(_ memo: MemoEntity) {
        Task { [weak self] in
            guard let `self` = self else {
                return
            }

            await self.viewModel.didTapEnrollMemo(memo)

            guard let state = self.viewModel.memoState else {
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

    @objc private func didTapMemoEnrollmentButton(_ sender: UIButton) {
        guard let data = memoView.generate(lectureCode) else {
            return
        }
        
        didEnrollMemo(data)
    }
}

extension MemoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text == "설명추가" else {
            return
        }

        textView.text = nil
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.trimmingCharacters(
            in: .whitespacesAndNewlines).isEmpty else {
            return
        }

        textView.text = "설명추가"
        textView.textColor = .systemGray
    }
}
