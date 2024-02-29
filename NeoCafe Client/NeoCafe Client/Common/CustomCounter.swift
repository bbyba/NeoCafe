//
//  CustomCounter.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

class CustomStepper: UIControl{
    var isDecrementing = false

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .poppins(ofSize: 16, weight: .semibold)
        return label
    }()

    lazy var incrementButton = stepperButton(color: .orangeCustom, titleColor: .ivoryCustom, text: "+")
    lazy var decrementButton = stepperButton(color: .greyCustom, titleColor: .darkBlueCustom, text: "-")

//    lazy var incrementButton = stepperButton(color: .orangeCustom, imageName: Asset.stepperPlus.image)
//    lazy var decrementButton = stepperButton(color: .greyCustom, imageName: Asset.stepperMinus.image)

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
        incrementButton.layer.cornerRadius = 17
        decrementButton.layer.cornerRadius = 17
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
        }
    }

    @objc private func handleDecrement() {
        if currentValue > minValue {
            currentValue -= stepValue
            sendActions(for: .valueChanged)
            isDecrementing = true
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
//    
//    private func stepperButton(color: UIColor, imageName: UIImage) -> UIButton {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        button.backgroundColor = color
//        button.setImage(imageName, for: .normal)
//        return button
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
