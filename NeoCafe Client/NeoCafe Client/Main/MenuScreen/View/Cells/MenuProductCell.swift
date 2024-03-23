//
//  MenuProductCell.swift
//  NeoCafe Client
//

import UIKit

class MenuProductCell: UICollectionViewCell {
    static let identifier = "MenuProductCell"
    var onAddToCart: ((Item) -> Void)?
    private var currentItem: Item?


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
        label.numberOfLines = 0 
        label.text = "Cafe Latte"
        return label
    }()

    lazy var priceLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .orangeCustom
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
        addTargets()
        setupShadow()
    }

    private func addTargets() {
        plusButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
    }

    private func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
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
            make.leading.trailing.equalToSuperview().inset(10)
        }

        priceLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(4)
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

    func configureData(item: Item) {
        currentItem = item
        image.image = UIImage(named: item.itemImage ?? Asset.coffeeCupFront.name)
        titleLabel.text = item.name
        priceLabel.text = "\(item.pricePerUnit) с"
    }

    @objc private func addToCartButtonTapped() {
        if let currentItem = currentItem {
            onAddToCart?(currentItem)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
