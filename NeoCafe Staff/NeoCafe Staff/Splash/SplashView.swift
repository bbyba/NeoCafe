//
//  SplashView.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

class SplashView: UIView {
    lazy var coffeeBeansImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.threeBrans.image
        return imageView
    }()

    lazy var waiterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.splashImage.image
        return imageView
    }()

    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.neocafe.image
        return imageView
    }()

    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = S.welcome
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 20, weight: .bold)
        return label
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

extension SplashView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(coffeeBeansImage)
        addSubview(waiterImage)
        addSubview(welcomeLabel)
        addSubview(logoImage)
    }

    func setupConstraints() {
        coffeeBeansImage.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.37)
            make.height.equalToSuperview().multipliedBy(0.28)
        }

        waiterImage.snp.makeConstraints { make in
            make.top.equalTo(coffeeBeansImage.snp.bottom).offset(88)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(230)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(waiterImage.snp.bottom).offset(48)
        }

        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(18)
        }
    }
}
