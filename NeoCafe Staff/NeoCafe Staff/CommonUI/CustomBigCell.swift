//
//  CustomBigCell.swift
//  NeoCafe Staff
//

import UIKit

class CustomBigCell: BaseCollectionViewCell {
    var onStepperValueChanged: ((_ newValue: Int) -> Void)?
    var onSwipeToDelete: ((IndexPath) -> Void)?

    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.numberOfLines = 0
        return label
    }()

    lazy var priceLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 12, weight: .regular)
        label.textColor = .darkBlueCustom
        label.numberOfLines = 0
        return label
    }()

    lazy var stepper = CustomStepper()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
        setupShadow()
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        addSwipeToDeleteGesture()
    }

    func configureData(item: Item, quantity: Int) {
        titleLabel.text = item.name
//        descriptionLabel.text = item.description
        priceLabel.text = S.pricePerItem(item.pricePerUnit)
        stepper.currentValue = quantity
    }

    func configureDataOrderScreen(item: ITO) {
        titleLabel.text = item.itemName
//        descriptionLabel.text = item.description
        priceLabel.text = S.pricePerItem(item.totalPrice)
        stepper.currentValue = item.quantity
    }

    private func addSwipeToDeleteGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToDelete(_:)))
        swipeGesture.direction = .left
        addGestureRecognizer(swipeGesture)
    }

    @objc private func handleSwipeToDelete(_ gesture: UISwipeGestureRecognizer) {
        guard let collectionView = superview as? UICollectionView,
              let indexPath = collectionView.indexPath(for: self) else {
            return
        }
        onSwipeToDelete?(indexPath)
    }

    @objc private func stepperValueChanged(_ sender: CustomStepper) {
        onStepperValueChanged?(sender.currentValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CustomBigCell: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
    }

    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stepper)
        contentView.addSubview(priceLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
        }

        stepper.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.height.equalTo(36)
        }

        stepper.decrementButton.snp.makeConstraints { make in
            make.height.width.equalTo(36)
        }

        stepper.incrementButton.snp.makeConstraints { make in
            make.height.width.equalTo(36)
        }
    }

    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
}
