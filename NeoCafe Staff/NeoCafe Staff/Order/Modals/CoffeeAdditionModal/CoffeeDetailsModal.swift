//
//  CoffeeDetailsModal.swift
//  NeoCafe Staff
//

import SnapKit
import UIKit

enum CoffeeDetailsSection: String, CaseIterable {
    case milk, syrup
}

class CoffeeDetailsModal: UIView {
    lazy var blurredBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = S.doneStatus
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var milkLabel: UILabel = {
        let label = UILabel()
        label.text = "Milk"
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var syrupLabel: UILabel = {
        let label = UILabel()
        label.text = "Syrup"
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var saveButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.save, backgroundColor: .lightBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var milkOption1 = OptionView(title: "Коровье молоко", milkOption: true)
    lazy var milkOption2 = OptionView(title: "Овсяное молоко", milkOption: true)
    lazy var milkOption3 = OptionView(title: "Соевое молоко", milkOption: true)

    lazy var syrupOption1 = OptionView(title: "Клубничный", milkOption: false)
    lazy var syrupOption2 = OptionView(title: "Карамельный", milkOption: false)

    lazy var milkStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [milkOption1, milkOption2, milkOption3])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    lazy var syrupStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [syrupOption1, syrupOption2])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CoffeeDetailsModal: BaseContentView {
    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(milkLabel)
        contentView.addSubview(milkStackView)
        contentView.addSubview(syrupLabel)
        contentView.addSubview(syrupStackView)
        contentView.addSubview(saveButton)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(419)
//            make.height.equalTo(600)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }

        milkLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
        }

        milkStackView.snp.makeConstraints { make in
            make.top.equalTo(milkLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        syrupLabel.snp.makeConstraints { make in
            make.top.equalTo(milkStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
        }

        syrupStackView.snp.makeConstraints { make in
            make.top.equalTo(syrupLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        saveButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
