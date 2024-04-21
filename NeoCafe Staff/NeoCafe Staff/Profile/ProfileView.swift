//
//  ProfileView.swift
//  NeoCafe Staff
//

import SnapKit
import UIKit

class ProfileView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.profile
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.text = S.workSchedule
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = S.name
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textColor = .lightBlueCustom
        return label
    }()

    lazy var backButton = CustomRoundButton(withImage: Asset.Images.arrowBack.image,
                                            backgroundColor: .lightBlueCustom)

    lazy var logoutButton = CustomRoundButton(withImage: Asset.Images.logout.image,
                                              backgroundColor: .lightBlueCustom)

    lazy var nameTextField = CustomTextField(iconName: Asset.Images.profile.image,
                                             customPlaceholder: "Alex")

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

extension ProfileView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        header.addSubview(logoutButton)
        addSubview(nameLabel)
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
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        scheduleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
