//
//  ProfileView.swift
//  NeoCafe Staff
//

import UIKit
import SnapKit

class ProfileView: UIView, BaseContentView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.profile
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.arrowBack.image, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .lightBlueCustom
        button.clipsToBounds = true
        return button
    }()

    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.exit.image, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .lightBlueCustom
        button.clipsToBounds = true
        return button
    }()

    lazy var nameTextField = CustomTextField(iconName: Asset.Images.profile.image, customPlaceholder: "Alex")

    lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.text = S.workSchedule
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        header.addSubview(logoutButton)
        addSubview(nameTextField)
        addSubview(scheduleLabel)
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
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        scheduleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
