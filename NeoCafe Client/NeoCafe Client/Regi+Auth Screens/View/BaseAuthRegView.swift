//
//  RegisterView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.02.
//
import Foundation
import UIKit
import SnapKit

class BaseAuthRegView: UIView {
    lazy var headerSection: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = Asset.Colors.blue.color
        return view
    }()

    lazy var headerImage: UIImageView = {
        let imageView = UIImageView(image: Asset.Splash.twoBeans.image)
        return imageView
    }()


    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.entry
        label.font = FontFamily.Poppins.bold.font(size: 32)
        label.textColor = Asset.Colors.ivory.color
        return label
    }()

    lazy var segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: [S.enter, S.registration])
        segmentedControl.contentMode = .scaleToFill
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    lazy var textFieldStackView = UIView()

    lazy var getCodebutton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.getCode, backgroundColor: Asset.Colors.darkBlue.color)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(headerSection)
        addSubview(headerImage)
        headerSection.addSubview(headerLabel)
        addSubview(segmentedControl)
        addSubview(textFieldStackView)
        addSubview(getCodebutton)
    }

    func setupConstraints() {
        headerSection.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }

        headerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(headerSection)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.trailing.equalToSuperview()
        }

        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(38)
        }

        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerSection.snp.bottom).inset(segmentedControl.frame.height / 2)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        getCodebutton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
