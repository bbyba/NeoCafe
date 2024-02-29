//
//  MenuProductCell.swift
//  NeoCafe Client
//

import UIKit

class MenuProductCell: UICollectionViewCell {
    static let identifier = "MenuProductCell"

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.coffeeCupTop.name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()

    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
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
        label.font = .poppins(ofSize: 14, weight: .semibold)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
        addSubviews()
        setupConstraints()
//        addTargets()
        setupShadow()
    }

    private func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
//        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
    }

    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(110)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(10)
        }

//        descriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(6)
//            make.leading.equalTo(image.snp.trailing).offset(12)
//            make.trailing.equalToSuperview().offset(-40)
//        }

        priceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }

        plusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(54)
        }
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }

    func configureData(imageName: String, name: String, price: Int) {
        image.image = UIImage(named: imageName)
        titleLabel.text = name
        priceLabel.text = String(price)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
