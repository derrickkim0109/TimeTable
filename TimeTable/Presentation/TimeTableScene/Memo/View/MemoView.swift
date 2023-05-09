//
//  MemoView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

import UIKit

final class MemoView: BaseView {
    let viewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = "메모 등록하기"
        return label
    }()

    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldTitleLabel,
                                                       titleTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()

    let textFieldTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "제목"
        return label
    }()

    let titleTextField: UITextField = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 20, weight: .medium)]
        let attributedPlaceholder = NSAttributedString(
            string: "제목 추가",
            attributes: attributes)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.attributedPlaceholder = attributedPlaceholder
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 14.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()

    lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionTextViewTitleLabel,
                                                       descriptionTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4

        return stackView
    }()

    let descriptionTextViewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "설명"
        return label
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "설명추가"
        textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textView.textColor = .systemGray
        textView.backgroundColor = .systemGray6
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.textContainerInset = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10)
        return textView
    }()

    let enrollButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("등록", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return button
    }()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [viewTitleLabel,
         titleStackView,
         descriptionStackView,
         enrollButton].forEach { addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            viewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 30),
            titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleStackView.heightAnchor.constraint(equalToConstant: 90)
        ])

        NSLayoutConstraint.activate([
            descriptionStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 30),
            descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionStackView.heightAnchor.constraint(equalToConstant: 280)
        ])

        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func generate(_ code: String?) -> MemoEntity? {
        if self.findViewController() is MemoViewController {
            let code = code ?? ""
            let title = titleTextField.text ?? ""
            let description = descriptionTextView.text ?? ""

            return MemoEntity(userKey: "",
                              lectureCode: code,
                              type: .exam,
                              title: title,
                              description: description,
                              date: Date().formattedDateString)
        }

        return nil
    }
}
