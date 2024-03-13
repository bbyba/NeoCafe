////
////  BonusModalView.swift
////  NeoCafe Client
////
//
//import UIKit
//import SnapKit
//
//enum BonusModalState {
//    case initialState
//    case inputBonusState
//    case confirmationState
//}
//
//class BonusModalView: UIView, BaseContentView {
//
//    var currentState: BonusModalState = .initialState
//
//    lazy var blurredBackgroundView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.alpha = 0.6
//        return view
//    }()
//
//    lazy var contentView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 16
//        return view
//    }()
//
//    lazy var headerLabel: UILabel = {
//        let label = UILabel()
//        label.text = S.useBonusPoints
//        label.font = .poppins(ofSize: 24, weight: .semibold)
//        label.textColor = .darkBlueCustom
//        label.textAlignment = .center
//        return label
//    }()
//
//    lazy var descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.text = S.useBonusPoints
//        label.font = .poppins(ofSize: 14, weight: .medium)
//        label.textColor = .darkBlueCustom
//        label.textAlignment = .center
//        return label
//    }()
//
//    lazy var textfield: CustomTextField = {
//        let textfield = CustomTextField(iconName: nil, customPlaceholder: "")
//        return textfield
//    }()
//
//    lazy var yesButton: CustomButton = {
//        let button = CustomButton()
//        button.setProperties(title: S.yes, backgroundColor: .darkBlueCustom, titleColor: .whiteCustom)
//        return button
//    }()
//
//    lazy var noButton : CustomButton = {
//        let button = CustomButton()
//        button.setProperties(title: S.no, backgroundColor: .clear, titleColor: .darkBlueCustom, showBorder: true)
//        return button
//    }()
//
//    lazy var goodButton: CustomButton = {
//        let button = CustomButton()
//        button.setProperties(title: S.perfect, backgroundColor: .darkBlueCustom, titleColor: .whiteCustom)
//        return button
//    }()
//
//    lazy var buttonStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 13
//        return stack
//    }()
//
//    //    override init(frame: CGRect) {
//    //        super.init(frame: frame)
//    //        addSubviews()
//    //        setupConstraints()
//    //    }
//
//    func addSubviews() {
//        addSubview(blurredBackgroundView)
//        addSubview(contentView)
//        contentView.addSubview((headerLabel))
//        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(textfield)
//        contentView.addSubview(buttonStack)
//        buttonStack.addArrangedSubview(noButton)
//        buttonStack.addArrangedSubview(yesButton)
//        contentView.addSubview(goodButton)
//    }
//
//    func setupConstraints() {
//        blurredBackgroundView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        contentView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(40)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//
//        headerLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(24)
//            make.centerX.equalToSuperview()
//        }
//
//        descriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(headerLabel.snp.bottom).offset(16)
//            make.centerX.equalToSuperview()
//        }
//
//        textfield.snp.makeConstraints { make in
//            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
//            make.leading.trailing.equalToSuperview().inset(24)
//            //            make.height.equalTo(54)
//        }
//
//        buttonStack.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-24)
//            make.centerX.equalToSuperview()
//        }
//
//        goodButton.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-24)
//            make.centerX.equalToSuperview()
//        }
//
//        textfield.isHidden = true
//        goodButton.isHidden = true
//    }
//
//    private func updateView() {
//        switch currentState {
//        case .initialState:
//            headerLabel.text = S.useBonusPoints
//            descriptionLabel.text = "У вас есть 100 бонусов, хотите использовать их?"
//            textfield.isHidden = true
//            buttonStack.isHidden = false
//            goodButton.isHidden = true
//            noButton.setTitle(S.no, for: .normal)
//            yesButton.setTitle(S.yes, for: .normal)
//        case .inputBonusState:
//            headerLabel.text = S.yourBonusPoints
//            descriptionLabel.text = S.enterBonusPoints
//            textfield.isHidden = false
//            noButton.setTitle(S.cancel, for: .normal)
//            yesButton.setTitle(S.use, for: .normal)
//        case .confirmationState:
//            headerLabel.text = S.useBonusPoints
//            descriptionLabel.text = S.orderAcceptedWait
//            textfield.isHidden = true
//            buttonStack.isHidden = true
//            goodButton.isHidden = false
//
//        }
//    }
//
//    func changeStateToPrevious() {
//        switch currentState {
//        case .initialState:
//            return viewmodel.dismiss
//        case .inputBonusState:
//            currentState = .initialState
//        case .confirmationState:
//            currentState = .inputBonusState
//        }
//        updateView()
//    }
//
//    func changeStateToNext() {
//        switch currentState {
//        case .initialState:
//            currentState = .inputBonusState
//        case .inputBonusState:
//            currentState = .confirmationState
//        case .confirmationState:
//            break
//        }
//        updateView()
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
