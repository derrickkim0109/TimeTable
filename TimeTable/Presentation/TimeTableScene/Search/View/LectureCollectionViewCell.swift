//
//  LectureCollectionViewCell.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class LectureCollectionViewCell: UICollectionViewCell {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lectureLabel,
                                                       lectureTimeView,
                                                       lectureCodeLabel,
                                                       professorNameLabel,
                                                       locationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        return stackView
    }()

    private let lectureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .systemBlue
        return label
    }()

    private lazy var lectureTimeView: LectureInfoView = LectureInfoView()

    private let lectureCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.systemGray3
        return label
    }()

    private let professorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.systemGray3
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.systemGray3
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupDefault()
        addUIComponents()
        configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupDefault() {
        lectureTimeView.iconImageView.image = UIImage(systemName: "clock")
    }

    private func addUIComponents() {
        contentView.addSubview(rootStackView)
    }

    private func configureLayouts() {
        let lectureLabelStandardPriority = lectureLabel.contentHuggingPriority(
            for: .vertical)
        lectureLabel.setContentHuggingPriority(
            lectureLabelStandardPriority + 1,
            for: .horizontal)

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }

    func configure(model: LectureEntity) {
        lectureLabel.text = model.lecture
        lectureCodeLabel.text = "교과목 코드 : " + model.code
        professorNameLabel.text = "담당 교수 : " + model.professor
        locationLabel.text = "강의실 : " + model.location
        lectureTimeView.dayDescriptionLabel.text = model.convertLectureSchedule()
    }
}

extension LectureCollectionViewCell: ReusableView { }
