//
//  BonusModalView.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

enum BonusModalState {
    case initialState
    case inputBonusState
    case confirmationState
}

class BonusModalView: UIView {
    var currentState: BonusModalState = .initialState

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

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.useBonusPoints
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = S.useBonusPoints
        label.font = .poppins(ofSize: 14, weight: .medium)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = S.availablePointsWant(UserDefaultsService.shared.customerProfile?.bonusPoints ?? 0)
        return label
    }()

    lazy var textfield: CustomTextField = {
        let textfield = CustomTextField(iconName: nil, customPlaceholder: "")
        return textfield
    }()

    lazy var yesButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.yes, backgroundColor: .darkBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var noButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.no, backgroundColor: .clear, titleColor: .darkBlueCustom, showBorder: true)
        return button
    }()

    lazy var useButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.use, backgroundColor: .darkBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var cancelButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.cancel, backgroundColor: .clear, titleColor: .darkBlueCustom, showBorder: true)
        return button
    }()

    lazy var goodButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.perfect, backgroundColor: .darkBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var useCancelButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, useButton])
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var yesNoButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noButton, yesButton])
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    private func updateView() {
        switch currentState {
        case .initialState:
            headerLabel.text = S.useBonusPoints
            descriptionLabel.text = S.availablePointsWant(UserDefaultsService.shared.customerProfile?.bonusPoints ?? 0)
            yesNoButtonStack.isHidden = false
            textfield.isHidden = true
            useCancelButtonStack.isHidden = true
            goodButton.isHidden = true
        case .inputBonusState:
            headerLabel.text = S.yourBonusPoints(UserDefaultsService.shared.customerProfile?.bonusPoints ?? 0)
            descriptionLabel.text = S.enterBonusPoints
            textfield.isHidden = false
            yesNoButtonStack.isHidden = true
            useCancelButtonStack.isHidden = false
            contentView.snp.updateConstraints { make in
                make.height.equalTo(265)
            }
        case .confirmationState:
            headerLabel.text = S.useBonusPoints
            descriptionLabel.text = S.orderAcceptedWait
            textfield.isHidden = true
            yesNoButtonStack.isHidden = true
            useCancelButtonStack.isHidden = true
            goodButton.isHidden = false
            contentView.snp.updateConstraints { make in
                make.height.equalTo(210)
            }
        }
    }

    func changeStateToPrevious() {
        switch currentState {
        case .initialState:
            return
        case .inputBonusState:
            currentState = .initialState
        case .confirmationState:
            currentState = .inputBonusState
        }
        updateView()
    }

    func changeStateToNext() {
        switch currentState {
        case .initialState:
            currentState = .inputBonusState
        case .inputBonusState:
            currentState = .confirmationState
        case .confirmationState:
            break
        }
        updateView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BonusModalView: BaseContentView {
    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(textfield)
        contentView.addSubview(yesNoButtonStack)
        contentView.addSubview(useCancelButtonStack)
        contentView.addSubview(goodButton)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(210)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        textfield.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        yesNoButtonStack.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }

        useCancelButtonStack.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }

        goodButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.leading.trailing.bottom.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }

        textfield.isHidden = true
        useCancelButtonStack.isHidden = true
        goodButton.isHidden = true
    }
}
