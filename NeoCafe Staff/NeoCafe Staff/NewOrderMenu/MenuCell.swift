//
//  MenuCell.swift
//  NeoCafe Staff
//

import UIKit

class MenuCell: BaseCollectionViewCell {
    var onAddToCart: EmptyCompletion?

    lazy var itemName: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .lightBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .lightBlueCustom
        return button
    }()

    lazy var priceLabelMenu: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .lightBlueCustom
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setupShadow()
        addSubviews()
        setupConstraints()
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }

    func configureData(menuItem: Item, newOrderView: Bool) {
        itemName.text = menuItem.name
        if newOrderView {
            priceLabel.text = "(\(menuItem.pricePerUnit))"
            priceLabelMenu.isHidden = true
            priceLabel.isHidden = false
            plusButton.isHidden = false
        } else {
            priceLabelMenu.text = "\(menuItem.pricePerUnit) сом"
            priceLabelMenu.isHidden = false
            priceLabel.isHidden = true
            plusButton.isHidden = true
        }
    }

    @objc private func plusButtonTapped() {
        onAddToCart?()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuCell: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
    }

    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }

    func addSubviews() {
        contentView.addSubview(itemName)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(priceLabelMenu)
    }

    func setupConstraints() {
        itemName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(itemName.snp.trailing).offset(4)
        }

        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(28)
            make.centerY.equalToSuperview()
        }

        priceLabelMenu.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
