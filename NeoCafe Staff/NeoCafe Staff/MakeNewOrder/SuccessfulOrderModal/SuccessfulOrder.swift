//
//  SuccessfulOrder.swift
//  NeoCafe Staff
//

import UIKit
import SnapKit

class SuccessfulOrderView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.newOrder
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()


    lazy var backButton = CustomRoundButton(withImage: Asset.Images.arrowBack.image,
                                            backgroundColor: .lightBlueCustom)

    lazy var checkMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.greenCheckMark.image
        return imageView
    }()

    lazy var informingLabel: UILabel = {
        let label = UILabel()
        label.text = S.newOrderSuccessfullyMade
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 24, weight: .bold)
        return label
    }()

    lazy var goToOrderButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.toOrder, backgroundColor: .lightBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SuccessfulOrderView: BaseContentView {

    func setProperties() {
        backgroundColor = .white
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(checkMarkImage)
        addSubview(informingLabel)
        addSubview(goToOrderButton)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        checkMarkImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }

        informingLabel.snp.makeConstraints { make in
            make.top.equalTo(checkMarkImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        goToOrderButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(informingLabel.snp.bottom).offset(32)
            make.height.equalTo(54)
        }
    }
}
