//
//  MenuCell.swift
//  NeoCafe Staff
//

import UIKit

class MenuCell: BaseCollectionViewCell {

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
        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .lightBlueCustom
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setupShadow()
        addSubviews()
        setupConstraints()
    }

    func configureData(menuItem: Item) {
        itemName.text = "\(menuItem.name)"
        priceLabel.text = "(\(menuItem.pricePerUnit))"
    }

    required init?(coder: NSCoder) {
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

    }
}
