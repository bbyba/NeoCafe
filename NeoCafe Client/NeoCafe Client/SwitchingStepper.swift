//  SwitchingStepper.swift
//  NeoCafe Client

import UIKit

protocol SwitchingStepperDelegate: AnyObject {
    func stepperValueDidChange(_ stepper: SwitchingStepper, value: Int)
    func stepperVisibilityChanged(_ stepper: SwitchingStepper, isVisible: Bool)
}

class SwitchingStepper: UIView {

    weak var delegate: SwitchingStepperDelegate?

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .whiteCustom
        button.backgroundColor = .orangeCustom
        button.layer.cornerRadius = 14
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        button.addTarget(self, action: #selector(showStepper), for: .touchUpInside)
        return button
    }()

    lazy var stepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        stepper.isHidden = true
        return stepper
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(plusButton)
        addSubview(stepper)
    }

    private func setupConstraints() {
        plusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(54)
        }

        stepper.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.trailing.bottom.equalToSuperview().inset(2)
        }
    }

    @objc private func showStepper() {
        toggleStepper(isVisible: true)
    }

    @objc private func stepperValueChanged(_ sender: CustomStepper) {
        delegate?.stepperValueDidChange(self, value: sender.currentValue)
        if sender.currentValue == 1 && sender.isDecrementing {
            toggleStepper(isVisible: false)
            sender.isDecrementing = false
        }
    }

    private func toggleStepper(isVisible: Bool) {
        plusButton.isHidden = isVisible
        stepper.isHidden = !isVisible
        delegate?.stepperVisibilityChanged(self, isVisible: isVisible)
    }

    func hideStepper() {
        toggleStepper(isVisible: false)
    }

    func hidePlusButton() {
        plusButton.isHidden = true
    }
}
