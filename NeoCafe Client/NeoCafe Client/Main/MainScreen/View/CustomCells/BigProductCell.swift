//
//  BigProductCell.swift
//  NeoCafe Client
//

import UIKit

class BigProductCell: BaseCollectionViewCell {
    var onStepperValueChanged: ((_ newValue: Int) -> Void)?
    var onSwipeToDelete: ((IndexPath) -> Void)?

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.coffeeCupTop.name)
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var titleLabel = {
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

    lazy var priceLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .orangeCustom
        return label
    }()

    lazy var statusLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .medium)
        label.textColor = .darkBlueCustom
        label.numberOfLines = 0
        return label
    }()

    lazy var switchingStepper = SwitchingStepper()
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

    func configureData(item: Item, quantity: Int? = nil) {
        image.image = UIImage(named: item.itemImage ?? Asset.coffeeCupFront.name)
        titleLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = S.som(item.pricePerUnit)

        if let quantity = quantity {
            switchingStepper.isHidden = true
            stepper.isHidden = false
            stepper.currentValue = quantity
        } else {
            switchingStepper.isHidden = true
            stepper.isHidden = true
        }
    }

    func configureForOrderHistory(item: OrderHistoryModel, isOrderHistoryCell: Bool) {
        image.image = UIImage(named: Asset.coffeeCupFront.name)
        titleLabel.text = item.branchName
        descriptionLabel.text = item.orderStatus
        statusLabel.text = item.orderStatus
        statusLabel.isHidden = !isOrderHistoryCell
        stepper.isHidden = isOrderHistoryCell
        switchingStepper.isHidden = isOrderHistoryCell
        priceLabel.isHidden = isOrderHistoryCell
    }

    func updatePriceLabel(newValue: Int, item: Item) {
        let totalPrice = item.pricePerUnit * newValue
        priceLabel.text = S.som(totalPrice)
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


extension BigProductCell: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
    }

    func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(switchingStepper)
        contentView.addSubview(stepper)
        stepper.isHidden = true
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

        statusLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(image.snp.trailing).offset(12)
        }

        switchingStepper.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(130)
        }

        stepper.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.height.equalTo(28)
        }

        statusLabel.isHidden = true
    }

    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
}
