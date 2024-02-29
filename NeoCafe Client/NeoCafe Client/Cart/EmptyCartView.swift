//
//  EmptyCartView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class EmptyCartView: UIView {

    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.cart
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .left
        return label
    }()

    lazy var orderHistoryButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.orderHistory.image, for: .normal)
        return button
    }()

    lazy var emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = S.emptyCart
        label.textAlignment = .center
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var emptyCartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.emptyCartImage.name)
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var toMenuButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.toMenu, backgroundColor: Asset.Colors.darkBlue.color)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerLabel)
        header.addSubview(orderHistoryButton)
        addSubview(emptyCartLabel)
        addSubview(emptyCartImage)
        addSubview(toMenuButton)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(55)
        }

        orderHistoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        emptyCartLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }

        emptyCartImage.snp.makeConstraints { make in
            make.top.equalTo(emptyCartLabel.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(24)
//            make.width.equalTo(327)
            make.bottom.equalTo(toMenuButton.snp.top).offset(-108)
        }

        toMenuButton.snp.makeConstraints { make in
//            make.top.equalTo(textFieldStackView.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

