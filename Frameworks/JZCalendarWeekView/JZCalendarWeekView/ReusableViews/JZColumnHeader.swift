//
//  JZColumnHeader.swift
//  JZCalendarWeekView
//
//  Created by Jeff Zhang on 28/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

/// Header for each column (section, day) in collectionView (Supplementary View)
open class JZColumnHeader: UICollectionReusableView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblWeekday, dayContainerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var dayContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lblDay)
        return view
    }()

    public var lblDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()

    public var lblWeekday: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    let calendarCurrent = Calendar.current
    public var dateFormatter = DateFormatter()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        backgroundColor = .clear
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(stackView)
        configureLayouts()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            lblDay.topAnchor.constraint(equalTo: dayContainerView.topAnchor),
            lblDay.bottomAnchor.constraint(equalTo: dayContainerView.bottomAnchor, constant: -5),
            lblDay.leadingAnchor.constraint(equalTo: dayContainerView.leadingAnchor, constant: 25),
            lblDay.trailingAnchor.constraint(equalTo: dayContainerView.trailingAnchor, constant: -25),

            dayContainerView.heightAnchor.constraint(equalToConstant: 23)
        ])
    }

    public func updateView(date: Date) {
        let weekday = calendarCurrent.component(.weekday, from: date) - 1

        lblDay.text = String(calendarCurrent.component(.day, from: date))
        lblWeekday.text = dateFormatter.shortWeekdaySymbols[weekday].uppercased()

        if date.isToday {
            lblDay.textColor = .white
            lblWeekday.textColor = JZWeekViewColors.today
            lblDay.backgroundColor = .systemBlue
            lblDay.clipsToBounds = true
            lblDay.layer.cornerRadius = 9
        } else {
            lblDay.textColor = JZWeekViewColors.columnHeaderDay
            lblDay.backgroundColor = .white
            lblWeekday.textColor = JZWeekViewColors.columnHeaderDay
            lblDay.clipsToBounds = false
            lblDay.layer.cornerRadius = 0
        }
    }
}
