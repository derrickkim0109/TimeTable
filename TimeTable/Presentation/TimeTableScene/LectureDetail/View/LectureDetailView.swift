//
//  LectureDetailView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class LectureDetailView: BaseView {
    private let rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       lectureInfoStackView,
                                                       lectureDescriptionTextView,
                                                       memoStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()

    private lazy var lectureInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lectureTimeView,
                                                       lectureCodeView,
                                                       lectureProfessorView,
                                                       lectureLocationView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    let lectureTimeView = LectureInfoView()
    let lectureCodeView = LectureInfoView()
    let lectureProfessorView = LectureInfoView()
    let lectureLocationView = LectureInfoView()

    let lectureDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.backgroundColor = .systemGray6
        textView.textColor = .systemGray
        textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textView.textContainerInset = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10)
        return textView
    }()

    lazy var memoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [memoTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    let memoTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "메모"
        return label
    }()

    let enrollButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return button
    }()

    override func setupDefault() {
        super.setupDefault()

        lectureDescriptionTextView.text = """
                        본 강의에서는 JSP를 이용한 웹 기반 프로그래밍 기초 및 응용기술에 대해 학습합니다.
                        특히, 실습 위주의 수업으로 프로그래밍 스킬 향상 및 실무 능력을 갖출수 있도록 합니다.
                        """
    }

    override func addUIComponents() {
        super.addUIComponents()

        rootScrollView.addSubview(rootStackView)

        [rootScrollView,
         enrollButton].forEach { addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            rootScrollView.topAnchor.constraint(equalTo: topAnchor),
            rootScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rootScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootScrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: rootScrollView.topAnchor),
            rootStackView.topAnchor.constraint(
                equalTo: rootScrollView.bottomAnchor),
            rootStackView.leadingAnchor.constraint(
                equalTo: rootScrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(
                equalTo: rootScrollView.trailingAnchor),
            rootStackView.widthAnchor.constraint(
                equalTo: widthAnchor),
        ])
    }
}
