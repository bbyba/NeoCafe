//
//  SplashView.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

class SplashView: UIView {
    lazy var coffeeBeansImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Splash.threeBeans.image
        return imageView
    }()

    lazy var coffeeCupsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Splash.coffeeCups.image
        return imageView
    }()

    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать в"
        label.textColor = .whiteCustom
        label.font = .poppins(ofSize: 20, weight: .bold)
        return label
    }()

    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Splash.neocafe.image
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashView: BaseContentView {
    func setProperties() {
        backgroundColor = .blueCustom
    }

    func addSubviews() {
        addSubview(coffeeBeansImage)
        addSubview(coffeeCupsImage)
        addSubview(welcomeLabel)
        addSubview(logoImage)
    }

    func setupConstraints() {
        coffeeBeansImage.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(coffeeCupsImage.snp.width)
        }

        coffeeCupsImage.snp.makeConstraints { make in
            make.top.equalTo(coffeeBeansImage.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(coffeeCupsImage.snp.width)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(coffeeCupsImage.snp.bottom).offset(48)
        }

        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(32)
        }
    }
}
