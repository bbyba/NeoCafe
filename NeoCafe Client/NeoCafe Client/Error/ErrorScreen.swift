//
//  ErrorScreen.swift
//  NeoCafe Client
//

import UIKit

// protocol ErrorViewDelegate: AnyObject {
//    func reloadLastRequest()
// }
//
// class ErrorView: UIView {
//
//    lazy var errorImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = Asset.error404Image.image
//        return imageView
//    }()
//
//    lazy var errorLabel: UILabel = {
//        let label = UILabel()
//        label.text = S.oopsSomethingsWrong
//        label.textColor = .blueCustom
//        label.font = .poppins(ofSize: 24, weight: .medium)
//        return label
//    }()
//
//    lazy var reloadbutton: CustomButton = {
//        let button = CustomButton()
//        button.setProperties(title: S.reload, backgroundColor: .darkBlueCustom)
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setProperties()
//        addSubviews()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
// }

protocol ErrorViewDelegate: AnyObject {
    func reloadLastRequest()
}

class ErrorView: UIView {
    weak var delegate: ErrorViewDelegate?

    lazy var errorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.error404Image.image
        return imageView
    }()

    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = S.oopsSomethingsWrong
        label.textColor = .blueCustom
        label.font = .poppins(ofSize: 24, weight: .medium)
        return label
    }()

    lazy var reloadButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.reload, backgroundColor: .darkBlueCustom)
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return button
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

    @objc private func reloadButtonTapped() {
        delegate?.reloadLastRequest()
    }
}

extension ErrorView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(errorImage)
        addSubview(errorLabel)
        addSubview(reloadButton)
    }

    func setupConstraints() {
        errorImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().dividedBy(2.8)
        }

        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorImage.snp.bottom).offset(32)
        }

        reloadButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(54)
        }
    }
}
