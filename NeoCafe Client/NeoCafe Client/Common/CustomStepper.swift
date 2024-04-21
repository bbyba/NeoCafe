//
//  CustomStepper.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

class CustomStepper: UIControl {
    var incrementTapped: (() -> Void)?
    var decrementTapped: (() -> Void)?
    var isDecrementing = false

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .poppins(ofSize: 16, weight: .semibold)
        return label
    }()

    lazy var incrementButton = stepperButton(color: .orangeCustom, titleColor: .ivoryCustom, text: "+")
    lazy var decrementButton = stepperButton(color: .greyCustom, titleColor: .darkBlueCustom, text: "-")

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()

    var minValue: Int = 1
    var maxValue: Int = 9
    var currentValue: Int = 1 {
        didSet {
            valueLabel.text = "\(currentValue)"
            sendActions(for: .valueChanged)
        }
    }

    var stepValue: Int = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        valueLabel.text = "\(currentValue)"
        addSubviews()
        setupConstraints()
        addTargets()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        incrementButton.layer.cornerRadius = 14
        decrementButton.layer.cornerRadius = 14
    }

    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(decrementButton)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(incrementButton)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }

    private func addTargets() {
        incrementButton.addTarget(self, action: #selector(handleIncrement), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(handleDecrement), for: .touchUpInside)
    }

    @objc private func handleIncrement() {
        if currentValue < maxValue {
            currentValue += stepValue
            sendActions(for: .valueChanged)
            isDecrementing = false
            incrementTapped?()
        }
    }

    @objc private func handleDecrement() {
        if currentValue > minValue {
            currentValue -= stepValue
            sendActions(for: .valueChanged)
            isDecrementing = true
            decrementTapped?()
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        let adjustment = sender.tag * stepValue
        if currentValue + adjustment <= maxValue, currentValue + adjustment >= minValue {
            currentValue += adjustment
        }
    }

    private func stepperButton(color: UIColor, titleColor: UIColor, text: String) -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle(text, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .highlighted)
        button.titleLabel?.font = .poppins(ofSize: 26, weight: .bold)
        button.backgroundColor = color
        return button
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
