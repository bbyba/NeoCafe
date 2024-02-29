//
//  PopularCell.swift
//  NeoCafe Client
//

import UIKit

class PopularCell: UICollectionViewCell {
    static let identifier = "PopularCell"

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.coffeeCupTop.name)
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .bold)
        label.textColor = .darkBlueCustom
        label.text = "Cafe Latte"
        return label
    }()

    lazy var descriptionLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 12, weight: .regular)
        label.textColor = .darkBlueCustom
        label.text = "Espresso with Milk"
        return label
    }()

    lazy var priceLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .bold)
        label.textColor = .orangeCustom
        label.text = "270 T"
        return label
    }()

    lazy var plusButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .whiteCustom
        button.backgroundColor = .orangeCustom
        button.layer.cornerRadius = 14
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        return button
    }()

    lazy var stepper = CustomStepper()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
        addSubviews()
        setupConstraints()
        addTargets()
        setupShadow()
    }

    private func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(stepper)
    }

    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(image.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(image.snp.trailing).offset(12)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(image.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-40)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(image.snp.trailing).offset(12)
        }

        plusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(54)
        }

        stepper.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.trailing.bottom.equalToSuperview().inset(2)
        }
        stepper.isHidden = true
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }

    func configureData(name: String, imageName: String) {
        image.image = UIImage(named: imageName)
        titleLabel.text = name
    }

    private func addTargets() {
        plusButton.addTarget(self, action: #selector(showStepper), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }

    @objc private func showStepper() {
        toggleCounter(isStepperVisible: true)
    }

    @objc private func stepperValueChanged(_ sender: CustomStepper) {
        if sender.currentValue == 1 && sender.isDecrementing {
            toggleCounter(isStepperVisible: false)
            sender.isDecrementing = false
        }
    }


    private func toggleCounter(isStepperVisible: Bool) {
        plusButton.isHidden = isStepperVisible
        stepper.isHidden = !isStepperVisible
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
