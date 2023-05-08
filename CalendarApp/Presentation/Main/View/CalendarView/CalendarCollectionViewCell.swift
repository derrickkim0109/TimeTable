//
//  CalendarCollectionViewCell.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

final class CalendarCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return label
    }()

    private let lectureRoomNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 7)
        return label
    }()

    private let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let memoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupDefault() {
        self.clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0
        self.backgroundColor = .gray
        borderView.backgroundColor = titleLabel.textColor
    }

    private func addUIComponents() {
        [titleLabel,
         lectureRoomNameLabel,
         borderView,
         memoStackView].forEach { contentView.addSubview($0) }
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
        ])

        NSLayoutConstraint.activate([
            lectureRoomNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            lectureRoomNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            lectureRoomNameLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            memoStackView.topAnchor.constraint(equalTo: lectureRoomNameLabel.bottomAnchor, constant: 2),
            memoStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            memoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func makeMemoViews(_ memos: [Memo]) {
        guard memoStackView.subviews.count != memos.count else {
            return
        }

        for memo in memos {
            let title = memo.title
            let image = UIImage(systemName: memo.type.rawValue)

            let memoTitleView = MemoTitleView()

            memoTitleView.memoIconImageView.image = image
            memoTitleView.memoTitleLabel.text = memo.type.korean + " " + title

            memoTitleView.backgroundColor = .gray
            memoTitleView.memoIconImageView.tintColor = borderView.backgroundColor

            memoStackView.addArrangedSubview(memoTitleView)
        }
    }

    func configureCell(event: CalendarEvent?) {
        guard let event = event else {
            return
        }
        
        titleLabel.text = event.title
        lectureRoomNameLabel.text = event.lecture
        makeMemoViews(event.memos)
    }
}

extension CalendarCollectionViewCell: ReusableView { }

